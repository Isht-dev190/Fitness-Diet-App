import 'dart:async';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:app_dev_fitness_diet/frontend/core/Models/fasting_option.dart';
import 'package:app_dev_fitness_diet/frontend/core/Models/fasting_log.dart';
import 'package:app_dev_fitness_diet/frontend/core/Models/fasting_model.dart';
import 'package:app_dev_fitness_diet/frontend/core/storage/fasting_storage_service.dart';
import 'package:app_dev_fitness_diet/frontend/core/secrets/hive_storage_service.dart';

class FastingViewModel extends ChangeNotifier {
  final _fastingStorage = FastingStorageService();
  final _userStorage = HiveStorageService();
  
  
  FastingOption _selectedOption = FastingOption.options[0];
  List<FastingLog> _logs = [];
  Timer? _timer;
  DateTime? _startTime;
  Duration _remainingTime = Duration.zero;
  bool _isRunning = false;
  String? _currentFastingId;

  FastingOption get selectedOption => _selectedOption;
  List<FastingLog> get logs => _logs;
  bool get isRunning => _isRunning;
  Duration get remainingTime => _remainingTime;

  FastingViewModel() {
    _loadFastingLogs();
    _checkForOngoingFasting();
  }

  Future<void> _loadFastingLogs() async {
    final userSession = _userStorage.getUserSession();
    if (userSession?.email == null) return;

    final fastings = _fastingStorage.getUserFastings(userSession!.email!);
    _logs = fastings.map((fasting) => FastingLog(
      startTime: fasting.startTime,
      endTime: fasting.endTime,
      fastingType: '${fasting.durationMinutes ~/ 60}:${fasting.durationMinutes % 60}',
      duration: fasting.endTime.difference(fasting.startTime),
    )).toList();

    _logs.sort((a, b) => b.startTime.compareTo(a.startTime));
    notifyListeners();
  }

  Future<void> _checkForOngoingFasting() async {
    final userSession = _userStorage.getUserSession();
    if (userSession?.email == null) return;

    final ongoingFastings = _fastingStorage.getUserFastings(userSession!.email!)
        .where((f) => !f.isCompleted);

    if (ongoingFastings.isNotEmpty) {
      final ongoing = ongoingFastings.first;
      _currentFastingId = ongoing.id;
      _startTime = ongoing.startTime;
      _selectedOption = FastingOption.options.firstWhere(
        (opt) => opt.fastingHours == ongoing.durationMinutes ~/ 60,
        orElse: () => FastingOption.options[0]
      );
      _isRunning = true;
      
      // Resume timer
      final elapsed = DateTime.now().difference(_startTime!);
      _remainingTime = Duration(minutes: ongoing.durationMinutes) - elapsed;
      
      _startTimer();
      notifyListeners();
    }
  }

  void selectOption(FastingOption option) {
    _selectedOption = option;
    if (!_isRunning) {
      _remainingTime = Duration(hours: option.fastingHours);
    }
    notifyListeners();
  }

  Future<void> startFasting() async {
    if (_isRunning) return;

    final userSession = _userStorage.getUserSession();
    if (userSession?.email == null) return;

    _isRunning = true;
    _startTime = DateTime.now();
    _remainingTime = _selectedOption.fastingDuration;

    // Create and save new fasting session
    _currentFastingId = const Uuid().v4();
    final fasting = Fasting(
      id: _currentFastingId!,
      startTime: _startTime!,
      endTime: _startTime!.add(_selectedOption.fastingDuration),
      durationMinutes: _selectedOption.isTestMode ? 2 : _selectedOption.fastingHours * 60,
      isCompleted: false,
      userEmail: userSession!.email!,
    );
    await _fastingStorage.saveFasting(fasting);

    _startTimer();
    notifyListeners();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final elapsed = DateTime.now().difference(_startTime!);
      _remainingTime = _selectedOption.fastingDuration - elapsed;

      if (_remainingTime.isNegative) {
        endFasting();
      } else {
        notifyListeners();
      }
    });
  }

  Future<void> endFasting() async {
    if (!_isRunning || _currentFastingId == null) return;

    _timer?.cancel();
    _isRunning = false;

    if (_startTime != null) {
      final endTime = DateTime.now();
      final duration = endTime.difference(_startTime!);

      // Update fasting in storage
      final fasting = _fastingStorage.getFasting(_currentFastingId!);
      if (fasting != null) {
        final updatedFasting = Fasting(
          id: fasting.id,
          startTime: fasting.startTime,
          endTime: endTime,
          durationMinutes: duration.inMinutes,
          isCompleted: true,
          userEmail: fasting.userEmail,
        );
        await _fastingStorage.updateFasting(updatedFasting);
      }

      // Update local logs
      _logs.insert(0, FastingLog(
        startTime: _startTime!,
        endTime: endTime,
        fastingType: _selectedOption.name,
        duration: duration,
      ));

      _startTime = null;
      _currentFastingId = null;
      _remainingTime = Duration(hours: _selectedOption.fastingHours);
    }

    notifyListeners();
  }

  String get formattedRemainingTime {
    final hours = _remainingTime.inHours;
    final minutes = _remainingTime.inMinutes.remainder(60);
    final seconds = _remainingTime.inSeconds.remainder(60);
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
} 