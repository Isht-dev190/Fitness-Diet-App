import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../auth/AuthService.dart';
import '../../core/Models/user_model.dart';

// Manages settings screen state and user authentication
class SettingsViewModel extends ChangeNotifier {
  // Authentication service instance
  final _authService = AuthService();
  
  // State management variables
  bool _isLoading = false;
  String? _error;

  // State getters for UI
  bool get isLoading => _isLoading;
  String? get error => _error;
  UserModel? get userData => _authService.userData;

  // Handles user sign out and navigation
  Future<void> signOut(BuildContext context) async {
    try {
      // Update loading state
      _isLoading = true;
      _error = null;
      notifyListeners();

      // Perform sign out
      await _authService.signOut();

      // Navigate to login screen
      if (context.mounted) {
        context.go('/');
      }
    } catch (e) {
      // Handle error state
      _error = e.toString();
    } finally {
      // Reset loading state
      _isLoading = false;
      notifyListeners();
    }
  }
} 