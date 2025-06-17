import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_dev_fitness_diet/frontend/core/Models/meal_model.dart';
import 'package:app_dev_fitness_diet/frontend/core/theme/app_pallete.dart';
import 'package:app_dev_fitness_diet/frontend/features/meals/meal_cubit.dart';
import 'package:app_dev_fitness_diet/frontend/features/meals/add_meal_screen.dart';
import 'package:provider/provider.dart';
import 'package:app_dev_fitness_diet/frontend/core/theme/theme_provider.dart';
import 'package:app_dev_fitness_diet/frontend/features/meals/meal_state.dart';



class MealCarouselScreen extends StatelessWidget {
  const MealCarouselScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;
    final textColor = isDark ? Colors.white : Colors.black;

    return BlocBuilder<MealCubit, MealState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.error != null) {
          return Center(child: Text('Error: ${state.error}'));
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppPallete.primaryColor, width: 2.0),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: PageView(
              children: [
                _buildAddMealPage(context, textColor),
                _buildMealListPage(context, state.meals),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAddMealPage(BuildContext context, Color textColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Add a New Meal',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton.icon(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddMealScreen(),
                  ),
                );
                if (context.mounted) {
                  context.read<MealCubit>().loadMeals();
                }
              },
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text(
                'Add a Meal',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppPallete.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMealListPage(BuildContext context, List<Meal> meals) {
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
          child: InkWell(
            onTap: () => _showMealDetails(context, meal),
            borderRadius: BorderRadius.circular(12.0),
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

  void _showMealDetails(BuildContext context, Meal meal) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        expand: false,
        builder: (context, scrollController) => Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: AppPallete.primaryColor,
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
      ),
    );
  }
} 