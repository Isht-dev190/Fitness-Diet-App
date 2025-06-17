
import 'package:app_dev_fitness_diet/frontend/core/theme/app_pallete.dart';
import 'package:app_dev_fitness_diet/frontend/core/theme/theme_event.dart';
import 'package:app_dev_fitness_diet/frontend/core/theme/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(isDark: false, themeData: _lightTheme)) {
    on<ToggleThemeEvent>((event, emit) {
      if (state.isDark) {
        emit(ThemeState(isDark: false, themeData: _lightTheme));
      } else {
        emit(ThemeState(isDark: true, themeData: _darkTheme));
      }
    });
  }


static final ThemeData _lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppPallete.lightBgColor,
    scaffoldBackgroundColor:AppPallete.lightBgColor ,
    appBarTheme: AppBarTheme(
      backgroundColor: AppPallete.lightBgColor,
      foregroundColor: AppPallete.darkBgColor,
      elevation: 0,
    ),
    cardTheme: CardTheme(
      color: AppPallete.lightBgColor,
      elevation: 2,
      shadowColor: Colors.grey.withOpacity(0.3),
    ),
    iconTheme: IconThemeData(color: AppPallete.darkBgColor),
    bottomAppBarTheme: BottomAppBarTheme(
      color: AppPallete.lightBgColor,
    ),
    textTheme: TextTheme(
      bodyMedium: TextStyle(color: AppPallete.darkBgColor),
    ),
  );



  static final ThemeData _darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppPallete.darkBgColor,
    scaffoldBackgroundColor: AppPallete.darkBgColor,
    appBarTheme: AppBarTheme(
      backgroundColor: AppPallete.darkBgColor,
      foregroundColor: AppPallete.lightBgColor,
      elevation: 0,
    ),
    cardTheme: CardTheme(
      color: AppPallete.darkBgColor,
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.3),
    ),
    iconTheme: IconThemeData(color: AppPallete.lightBgColor),
    bottomAppBarTheme: BottomAppBarTheme(
      color: AppPallete.darkBgColor,
    ),
    textTheme: TextTheme(
      bodyMedium: TextStyle(color: AppPallete.lightBgColor),
    ),
  );
}