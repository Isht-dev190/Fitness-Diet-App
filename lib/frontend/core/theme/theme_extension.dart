import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_dev_fitness_diet/frontend/core/theme/theme_bloc.dart';

extension ThemeModeExt on BuildContext {
  bool get isDarkMode => watch<ThemeBloc>().state.isDark;
}
