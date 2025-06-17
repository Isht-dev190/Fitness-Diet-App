import 'package:app_dev_fitness_diet/frontend/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_dev_fitness_diet/frontend/core/theme/theme_provider.dart';

import 'package:go_router/go_router.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;
    final backgroundColor = isDark ? AppPallete.darkBgColor : AppPallete.lightBgColor;
    final textColor = isDark ? AppPallete.textColorDarkMode : AppPallete.textColorLightMode;

    return Drawer(
      backgroundColor: backgroundColor,
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: backgroundColor,
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                fontSize: 24,
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.fitness_center, color: AppPallete.primaryColor),
            title: Text(
              'Workouts',
              style: TextStyle(
                color: textColor,
                fontSize: 16,
              ),
            ),
            onTap: () {
              context.go('/dashboard/workouts');
            },
          ),
          const SizedBox(height: 20),
          ListTile(
            leading: const Icon(Icons.restaurant_menu, color: AppPallete.primaryColor),
            title: Text(
              'Meals',
              style: TextStyle(
                color: textColor,
                fontSize: 16,
              ),
            ),
            onTap: () {
              context.go('/dashboard/meals');
            },
          ),
          const SizedBox(height: 20),
          ListTile(
            leading: const Icon(Icons.timer, color: AppPallete.primaryColor),
            title: Text(
              'Intermittent Fasting',
              style: TextStyle(
                color: textColor,
                fontSize: 16,
              ),
            ),
            onTap: () {
              
              context.go('/dashboard/fasting');
            },
          ),
          const SizedBox(height: 20),
          ListTile(
            leading: const Icon(Icons.settings, color: AppPallete.primaryColor),
            title: Text(
              'Settings',
              style: TextStyle(
                color: textColor,
                fontSize: 16,
              ),
            ),
            onTap: () {
            
              context.go('/dashboard/settings');
            },
          ),
        ],
      ),
    );
  }
}