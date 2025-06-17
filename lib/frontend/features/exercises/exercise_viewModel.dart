import 'package:flutter/material.dart';
import 'package:app_dev_fitness_diet/frontend/core/Models/exercise_model.dart';
import 'exercise_repo.dart';

class ExerciseViewModel extends ChangeNotifier {
  final ExerciseRepository _repository;
  bool _isLoading = false;
  String? _error;
  List<Exercise> _exercises = [];
  String _searchQuery = '';
  List<Exercise> _filteredExercises = [];

  ExerciseViewModel(this._repository) {
    _loadExercises();
  }

  bool get isLoading => _isLoading;
  String? get error => _error;
  List<Exercise> get exercises => _searchQuery.isEmpty ? _exercises : _filteredExercises;
  String get searchQuery => _searchQuery;

  Future<void> _loadExercises() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    final result = await _repository.getExercises();
    result.fold(
      (failure) {
        _error = failure.message;
        _exercises = [];
      },
      (exercises) {
        _exercises = exercises;
        _error = null;
        _filterExercises();
      },
    );

    _isLoading = false;
    notifyListeners();
  }

  void updateSearchQuery(String query) {
    _searchQuery = query;
    _filterExercises();
    notifyListeners();
  }

  void _filterExercises() {
    if (_searchQuery.isEmpty) {
      _filteredExercises = _exercises;
    } else {
      _filteredExercises = _exercises.where((exercise) {
        return exercise.category.toLowerCase().contains(_searchQuery.toLowerCase()) ||
               exercise.name.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    }
  }

  void refreshExercises() {
    _loadExercises();
  }

  Exercise? getExerciseByName(String name) {
    try {
      return _exercises.firstWhere((exercise) => exercise.name == name);
    } catch (e) {
      return null;
    }
  }
}
