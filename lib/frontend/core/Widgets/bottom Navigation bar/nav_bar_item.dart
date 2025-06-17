import 'package:app_dev_fitness_diet/frontend/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_dev_fitness_diet/frontend/core/theme/theme_provider.dart';

class NavBarItem extends StatelessWidget {
  final dynamic icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const NavBarItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;
    final color = isSelected 
        ? AppPallete.primaryColor 
        : (isDark ? AppPallete.textColorDarkMode : AppPallete.textColorLightMode);

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon is IconData 
              ? Icon(icon, color: color, size: 23)
              : icon,
          const SizedBox(height: 3),
          Text(
            label,
            style: TextStyle(color: color, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
