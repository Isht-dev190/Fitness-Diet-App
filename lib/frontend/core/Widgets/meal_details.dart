import 'package:flutter/material.dart';
import 'package:app_dev_fitness_diet/frontend/core/Models/meal_model.dart';
import 'package:app_dev_fitness_diet/frontend/core/theme/app_pallete.dart';

class MealDetails extends StatelessWidget {
  final Meal meal;

  const MealDetails({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      maxChildSize: 0.9,
      minChildSize: 0.5,
      expand: false,
      builder: (context, scrollController) => Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: AppPallete.lightPrimaryColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  meal.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: meal.foods.length,
              itemBuilder: (context, index) {
                final mealFood = meal.foods[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          mealFood.food.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text('Portion: ${mealFood.portionSize}g'),
                        Text('Calories: ${mealFood.calories.toStringAsFixed(1)}'),
                        Text('Protein: ${mealFood.food.protein}g'),
                        Text('Carbs: ${mealFood.food.carbs}g'),
                        Text('Fats: ${mealFood.food.fats}g'),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
} 