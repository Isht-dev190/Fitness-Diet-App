import 'package:app_dev_fitness_diet/frontend/core/Widgets/dashboard drawer/custom_drawer.dart';
import 'package:app_dev_fitness_diet/frontend/core/theme/app_pallete.dart';
import 'package:app_dev_fitness_diet/frontend/core/Widgets/bottom Navigation bar/bottom_nav_bar.dart';
import 'package:app_dev_fitness_diet/frontend/core/Widgets/app bar/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_dev_fitness_diet/frontend/core/theme/theme_provider.dart';
import 'package:app_dev_fitness_diet/frontend/features/workouts/workout_carousel_screen.dart';
import 'package:app_dev_fitness_diet/frontend/features/meals/meal_carousel_view.dart';

class Dashboard extends StatelessWidget {
  final Widget child;
  final String currentRoute;

  const Dashboard({
    super.key,
    required this.child,
    required this.currentRoute,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;
    final backgroundColor = isDark ? AppPallete.darkBgColor : AppPallete.lightBgColor;
    final textColor = isDark ? AppPallete.textColorDarkMode : AppPallete.textColorLightMode;
    final isRootRoute = currentRoute == '/dashboard';

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: isRootRoute ? const CustomAppBar(isRootRoute: true) : null,
      drawer: isRootRoute ? const CustomDrawer() : null,
      body: isRootRoute ? const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               SizedBox(
                height: 300,
                child: MealCarouselScreen(),
              ),
              
             
              SizedBox(
                height: 300,
                child: WorkoutCarouselScreen(),
              ),
            ],
          ),
        ),
      ) : child,
      bottomNavigationBar: BottomNavBar(currentRoute: currentRoute),
    );
  }
}