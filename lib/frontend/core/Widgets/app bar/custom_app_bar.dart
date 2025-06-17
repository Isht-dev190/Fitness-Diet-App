import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_dev_fitness_diet/frontend/core/theme/theme_provider.dart';
import 'package:app_dev_fitness_diet/frontend/core/theme/app_pallete.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isRootRoute;

  const CustomAppBar({
    super.key,
    this.isRootRoute = true,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;
    final backgroundColor = isDark ? AppPallete.darkBgColor : AppPallete.lightBgColor;
    final textColor = isDark ? AppPallete.textColorDarkMode : AppPallete.textColorLightMode;

    return AppBar(
      backgroundColor: backgroundColor,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      leading: Builder(
        builder: (context) => IconButton(
          icon: Icon(
            isRootRoute ? Icons.menu : Icons.arrow_back,
            color: textColor,
          ),
          onPressed: isRootRoute 
            ? () => Scaffold.of(context).openDrawer()
            : () => context.go('/dashboard'),
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(
            themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            color: AppPallete.primaryColor,
          ),
          onPressed: () {
            themeProvider.toggleTheme();
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
} 