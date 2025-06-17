import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../core/secrets/hive_storage_service.dart';
import '../../core/storage/user_storage_service.dart';
import '../../core/Models/user_model.dart';

class AuthService extends ChangeNotifier {
  final _supabase = Supabase.instance.client;
  final _storageService = HiveStorageService();
  final _userStorage = UserStorageService();
  bool _isLoading = false;
  String? _error;
  User? _currentUser;
  UserModel? _userData;
  bool _isInitialized = false;

  bool get isLoading => _isLoading;
  String? get error => _error;
  User? get currentUser => _currentUser;
  UserModel? get userData => _userData;
  bool get isInitialized => _isInitialized;

  AuthService() {
    _initializeAuth();
  }

  Future<void> _initializeAuth() async {
    if (_isInitialized) return;

    try {
      // Check for stored session
      final session = _storageService.getUserSession();
      final sessionEmail = session?.email;
      if (session?.sessionId != null && sessionEmail != null) {
        // Try to get current Supabase session
        final currentSession = _supabase.auth.currentSession;
        if (currentSession != null) {
          _currentUser = currentSession.user;
          // Load user data from Hive
          _userData = _userStorage.getUser(sessionEmail);
        }
      }

      // Listen for auth state changes
      _supabase.auth.onAuthStateChange.listen((event) {
        _currentUser = event.session?.user;
        final email = _currentUser?.email;
        if (_currentUser != null && email != null) {
          _loadUserData(email);
        } else {
          _userData = null;
        }
        notifyListeners();
      });
    } catch (e) {
      // If session is invalid, clear it
      await _storageService.clearUserSession();
      _currentUser = null;
      _userData = null;
    } finally {
      _isInitialized = true;
      notifyListeners();
    }
  }

  Future<void> _loadUserData(String email) async {
    try {
      _userData = _userStorage.getUser(email);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<bool> signIn(String email, String password) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.session != null) {
        await _storageService.saveUserSession(
          email,
          response.session!.accessToken,
        );
        await _loadUserData(email);
        return true;
      }
      _error = 'Failed to sign in';
      return false;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> signUp(UserModel user) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      // storing user data in Hive
      await _userStorage.saveUser(user);

      final response = await _supabase.auth.signUp(
        email: user.email,
        password: user.password,
        data: {
          'bmi': user.bmi,
          'tdee': user.tdee,
          'height': user.height,
          'weight': user.weight,
          'age': user.age,
          'email': user.email,
          'gender': user.gender
        }
      );

      if (response.session != null) {
        await _storageService.saveUserSession(
          user.email,
          response.session!.accessToken,
        );
        _userData = user;
        notifyListeners();
        return true;
      }
      
      // If Supabase registration fails, clean up Hive data
      await _userStorage.deleteUser(user.email);
      _error = 'Failed to sign up';
      return false;
    } catch (e) {
      // Clean up any partial registrations
      try {
        await _userStorage.deleteUser(user.email);
        await _storageService.clearUserSession();
      } catch (_) {
        // Ignore cleanup errors
      }
      _error = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final email = _currentUser?.email;
      if (email != null) {
        // Clean up user data first
        await _userStorage.deleteUser(email);
      }

      // Clear session
      await _storageService.clearUserSession();
      
      // Clear local state
      _currentUser = null;
      _userData = null;
      notifyListeners();

      // Then sign out from Supabase
      await _supabase.auth.signOut();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> checkSession() async {
    if (!_isInitialized) {
      await _initializeAuth();
    }
    
    final session = _storageService.getUserSession();
    final sessionEmail = session?.email;
    if (session?.sessionId != null && sessionEmail != null) {
      try {
        final currentSession = _supabase.auth.currentSession;
        if (currentSession != null) {
          _userData = _userStorage.getUser(sessionEmail);
          notifyListeners();
          return true;
        }
      } catch (e) {
        return false;
      }
    }
    return false;
  }

  Future<bool> _accountExists(String email) async {
    try {
      return _userStorage.userExists(email);
    } catch (e) {
      return false;
    }
  }

  Future<bool> signInWithGoogle() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      // Start Google Sign In flow with Supabase
      final response = await _supabase.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: 'https://nndllhdsacjihdturdrv.supabase.co/auth/v1/callback',
        queryParams: {
          'access_type': 'offline',
          'prompt': 'consent',
        },
      );

      if (!response) {
        _error = 'User cancelled Google Sign In';
        return false;
      }

      final authState = await _supabase.auth.onAuthStateChange.firstWhere(
        (state) => state.session != null || state.event == AuthChangeEvent.signedOut,
        orElse: () => const AuthState(AuthChangeEvent.signedOut, null),
      );

      if (authState.session == null) {
        _error = 'Failed to complete Google Sign In. Please check if you have allowed pop-ups and try again.';
        return false;
      }

      final email = authState.session?.user.email;
      if (email == null) {
        _error = 'No email found from Google account';
        return false;
      }

      // Check if account exists in our app
      final accountExists = await _accountExists(email);
      if (!accountExists) {
        await _supabase.auth.signOut();
        _error = 'No account found for this Google account. Please sign up first.';
        return false;
      }

      // Load user data and save session
      await _loadUserData(email);
      await _storageService.saveUserSession(
        email,
        authState.session!.accessToken,
      );

      return true;
    } catch (e) {
      _error = 'Google Sign In failed: ${e.toString()}. Please make sure pop-ups are allowed and try again.';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> signUpWithGoogle() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      // Start Google Sign In flow with Supabase
      final response = await _supabase.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: 'https://nndllhdsacjihdturdrv.supabase.co/auth/v1/callback',
        queryParams: {
          'access_type': 'offline',
          'prompt': 'consent',
        },
      );

      if (!response) {
        _error = 'User cancelled Google Sign Up';
        return false;
      }

      // Wait for auth state change to get the session
      final authState = await _supabase.auth.onAuthStateChange.firstWhere(
        (state) => state.session != null || state.event == AuthChangeEvent.signedOut,
        orElse: () => const AuthState(AuthChangeEvent.signedOut, null),
      );

      if (authState.session == null) {
        _error = 'Failed to complete Google Sign Up. Please check if you have allowed pop-ups and try again.';
        return false;
      }

      final email = authState.session?.user.email;
      if (email == null) {
        _error = 'No email found from Google account';
        return false;
      }

      // Check if account already exists
      final accountExists = await _accountExists(email);
      if (accountExists) {
        await _supabase.auth.signOut();
        _error = 'An account already exists for this Google account. Please sign in instead.';
        return false;
      }

      // Create a UserModel from Google data
      final userModel = UserModel(
        email: email,
        password: '', 
        age: '0', 
        gender: '',
        height: 0,
        weight: 0,
        lifestyle: 'sedentary', // Default value
        bmi: 0,
        tdee: 0,
      );

      // Store user data in Hive
      await _userStorage.saveUser(userModel);
      
      // Save session
      await _storageService.saveUserSession(
        email,
        authState.session!.accessToken,
      );

      _userData = userModel;
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'Google Sign Up failed: ${e.toString()}. Please make sure pop-ups are allowed and try again.';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}