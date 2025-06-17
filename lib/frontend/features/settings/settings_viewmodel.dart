import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../auth/AuthService.dart';
import '../../core/Models/user_model.dart';

class SettingsViewModel extends ChangeNotifier {
  final _authService = AuthService();
  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;
  String? get error => _error;
  UserModel? get userData => _authService.userData;

  Future<void> signOut(BuildContext context) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await _authService.signOut();

      if (context.mounted) {
       
        context.go('/');
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
} 