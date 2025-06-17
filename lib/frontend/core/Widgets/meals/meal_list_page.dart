import 'package:flutter/material.dart';
import 'package:app_dev_fitness_diet/frontend/core/Models/meal_model.dart';
import 'package:app_dev_fitness_diet/frontend/core/theme/app_pallete.dart';

class MealListPage extends StatelessWidget {
  final List<Meal> meals;
  final Function(BuildContext, Meal) onMealTap;

  const MealListPage({
    super.key,
    required this.meals,
    required this.onMealTap,
  });

  @override
  Widget build(BuildContext context) {
    if (meals.isEmpty) {
      return const Center(
        child: Text('No meals yet. Add your first meal!'),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: meals.length,
      itemBuilder: (context, index) {
        final meal = meals[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
            side: const BorderSide(color: AppPallete.primaryColor),
          ),
          child: GestureDetector(
            onTap: () => onMealTap(context, meal),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meal.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Foods: ${meal.foods.length}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    'Total Calories: ${meal.totalCalories.toStringAsFixed(1)}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
} 