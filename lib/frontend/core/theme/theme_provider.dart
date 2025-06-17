import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  static const String _themeKey = 'isDarkMode';
  SharedPreferences? _prefs;
  bool _isDarkMode = false;
  bool _isInitialized = false;

  bool get isDarkMode => _isDarkMode;
  bool get isInitialized => _isInitialized;
  ThemeMode get themeMode => _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  ThemeProvider() {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    _prefs = await SharedPreferences.getInstance();
    _isDarkMode = _prefs?.getBool(_themeKey) ?? false;
    _isInitialized = true;
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    if (!_isInitialized) {
      await _loadTheme();
    }
    _isDarkMode = !_isDarkMode;
    await _prefs?.setBool(_themeKey, _isDarkMode);
    notifyListeners();
  }
} 