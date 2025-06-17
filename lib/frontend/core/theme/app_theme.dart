import 'package:app_dev_fitness_diet/frontend/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppPallete.lightBgColor,
    primaryColor: AppPallete.primaryColor,
    hintColor: AppPallete.textColorLightMode,
    colorScheme: const ColorScheme.light(
      primary: AppPallete.primaryColor,
      secondary: AppPallete.lightPrimaryColor,
     // background: AppPallete.lightBgColor,
      surface: AppPallete.lightBgColor,
      //onBackground: AppPallete.textColorLightMode,
      onSurface: AppPallete.textColorLightMode,
    ),
    cardTheme: const CardTheme(
      color: AppPallete.lightBgColor,
      elevation: 0,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppPallete.textColorLightMode),
      bodyMedium: TextStyle(color: AppPallete.textColorLightMode),
      titleLarge: TextStyle(color: AppPallete.textColorLightMode),
      titleMedium: TextStyle(color: AppPallete.textColorLightMode),
      titleSmall: TextStyle(color: AppPallete.textColorLightMode),
    ),
    iconTheme: const IconThemeData(
      color: AppPallete.textColorLightMode,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppPallete.lightBgColor,
      foregroundColor: AppPallete.textColorLightMode,
      elevation: 0,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppPallete.darkBgColor,
    primaryColor: AppPallete.primaryColor,
    hintColor: AppPallete.textColorDarkMode,
    colorScheme: const ColorScheme.dark(
      primary: AppPallete.primaryColor,
      secondary: AppPallete.lightPrimaryColor,
      //background: AppPallete.darkBgColor,
      surface: AppPallete.darkBgColor,
    //  onBackground: AppPallete.textColorDarkMode,
      onSurface: AppPallete.textColorDarkMode,
    ),
    cardTheme: const CardTheme(
      color: AppPallete.darkBgColor,
      elevation: 0,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppPallete.textColorDarkMode),
      bodyMedium: TextStyle(color: AppPallete.textColorDarkMode),
      titleLarge: TextStyle(color: AppPallete.textColorDarkMode),
      titleMedium: TextStyle(color: AppPallete.textColorDarkMode),
      titleSmall: TextStyle(color: AppPallete.textColorDarkMode),
    ),
    iconTheme: const IconThemeData(
      color: AppPallete.textColorDarkMode,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppPallete.darkBgColor,
      foregroundColor: AppPallete.textColorDarkMode,
      elevation: 0,
    ),
  );
}
