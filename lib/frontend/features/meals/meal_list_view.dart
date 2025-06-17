import 'package:flutter/material.dart';
import 'package:app_dev_fitness_diet/frontend/core/Models/meal_model.dart';
import 'package:app_dev_fitness_diet/frontend/core/theme/app_pallete.dart';
import 'package:app_dev_fitness_diet/frontend/core/Widgets/meal_card.dart';
import 'package:app_dev_fitness_diet/frontend/core/Widgets/meal_details.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_dev_fitness_diet/frontend/features/meals/meal_cubit.dart';
import 'package:provider/provider.dart';
import 'package:app_dev_fitness_diet/frontend/core/theme/theme_provider.dart';
import 'package:app_dev_fitness_diet/frontend/features/meals/meal_state.dart';



class MealListView extends StatelessWidget {
  const MealListView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;
    final backgroundColor = isDark ? AppPallete.darkBgColor : AppPallete.lightBgColor;
    final textColor = isDark ? AppPallete.textColorDarkMode : AppPallete.textColorLightMode;

    return BlocBuilder<MealCubit, MealState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            backgroundColor: backgroundColor,
            elevation: 0,
            surfaceTintColor: Colors.transparent,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: textColor,
              ),
              onPressed: () => context.go('/dashboard'),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  isDark ? Icons.light_mode : Icons.dark_mode,
                  color: AppPallete.primaryColor,
                ),
                onPressed: () => themeProvider.toggleTheme(),
              ),
            ],
          ),
          body: _buildBody(context, state, textColor),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, MealState state, Color textColor) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.error != null) {
      return Center(child: Text(state.error!));
    }

    if (state.meals.isEmpty) {
      return Center(
        child: Text(
          'No meals yet',
          style: TextStyle(
            fontSize: 18,
            color: textColor,
          ),
        ),
      );
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Center(
            child: Text(
              'Your Meals',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: state.meals.length,
            itemBuilder: (context, index) {
              final meal = state.meals[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: InkWell(
                  onTap: () => _showMealDetails(context, meal),
                  child: MealCard(meal: meal),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _showMealDetails(BuildContext context, Meal meal) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => MealDetails(meal: meal),
    );
  }
} 