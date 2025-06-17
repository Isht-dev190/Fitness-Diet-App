import 'package:app_dev_fitness_diet/frontend/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_dev_fitness_diet/frontend/core/theme/theme_provider.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;
    final backgroundColor = isDark ? AppPallete.darkBgColor : AppPallete.lightBgColor;
   // final textColor = isDark ? AppPallete.textColorDarkMode : AppPallete.textColorLightMode;

    return Container(
      color: backgroundColor,
      child: Column(
        children: [
          Container(),
          Container(),
        ],
      ),
    );
  }
} 