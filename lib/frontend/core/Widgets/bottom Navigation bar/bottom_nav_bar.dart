import 'package:app_dev_fitness_diet/frontend/core/Widgets/bottom%20Navigation%20bar/nav_bar_item.dart';
import 'package:app_dev_fitness_diet/frontend/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:app_dev_fitness_diet/frontend/core/theme/theme_provider.dart';

class BottomNavBar extends StatelessWidget {
  final String currentRoute;

  const BottomNavBar({
    super.key,
    required this.currentRoute,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;
    final backgroundColor = isDark ? AppPallete.darkBgColor : AppPallete.lightBgColor;

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            NavBarItem(
              icon: Icons.home,
              label: 'Home',
              isSelected: currentRoute == '/dashboard',
              onTap: () => context.go('/dashboard'),
            ),
            const SizedBox(width: 5),
            NavBarItem(
              icon: Icons.fitness_center,
              label: 'Exercises',
              isSelected: currentRoute == '/dashboard/exercises',
              onTap: () => context.go('/dashboard/exercises'),
            ),
            const SizedBox(width: 5),
            NavBarItem(
              icon: Icons.fastfood,
              label: 'Foods',
              isSelected: currentRoute == '/dashboard/foods',
              onTap: () => context.go('/dashboard/foods'),
            ),
            const SizedBox(width: 5),
            NavBarItem(
              icon: Icons.lightbulb_outline_rounded,
              label: 'Tips',
              isSelected: currentRoute == '/dashboard/ai',
              onTap: () => context.go('/dashboard/ai'),
            ),
          ],
        ),
      ),
    );
  }
}