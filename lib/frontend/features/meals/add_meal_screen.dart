import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:app_dev_fitness_diet/frontend/core/Models/food_model.dart';
import 'package:app_dev_fitness_diet/frontend/features/meals/meal_cubit.dart';
import 'package:app_dev_fitness_diet/frontend/features/foods/food_viewModel.dart';
import 'package:app_dev_fitness_diet/frontend/features/auth/AuthService.dart';
import 'package:app_dev_fitness_diet/frontend/features/meals/meal_state.dart';
import 'package:app_dev_fitness_diet/frontend/features/meals/portion_size_cubit.dart';
import 'package:app_dev_fitness_diet/frontend/features/meals/portionSizeDialog.dart';

// Screen for adding a new meal
class AddMealScreen extends StatelessWidget {
  const AddMealScreen({Key? key}) : super(key: key);

  // Builds the add meal screen with a stepper for food selection and meal naming
  @override
  Widget build(BuildContext context) {
    final mealCubit = context.read<MealCubit>();
    final foodViewModel = Provider.of<FoodViewModel>(context, listen: false);
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create a Meal'),
      ),
      body: BlocBuilder<MealCubit, MealState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // Stepper for selecting foods and naming the meal
          return Stepper(
            currentStep: state.currentStep,
            onStepContinue: () {
              if (state.currentStep < 1) {
                if (state.selectedFoods.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please add at least one food')),
                  );
                  return;
                }
                mealCubit.updateCurrentStep(state.currentStep + 1);
              } else {
                if (state.mealName.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter a meal name')),
                  );
                  return;
                }
                final userEmail = authService.currentUser?.email;
                if (userEmail == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('User email not found')),
                  );
                  return;
                }
                mealCubit.saveMeal(userEmail);
                context.pop();
              }
            },
            onStepCancel: () {
              if (state.currentStep > 0) {
                mealCubit.updateCurrentStep(state.currentStep - 1);
              } else {
                context.pop();
              }
            },
            steps: [
              Step(
                title: const Text('Select Foods'),
                content: Column(
                  children: [
                    // Button to add a food to the meal
                    ElevatedButton(
                      onPressed: () async {
                        final selectedFood = await showDialog<Food>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Select Food'),
                            content: SizedBox(
                              width: double.maxFinite,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: foodViewModel.foods.length,
                                itemBuilder: (context, index) {
                                  final food = foodViewModel.foods[index];
                                  return ListTile(
                                    title: Text(food.name),
                                    subtitle: Text('${food.calories} calories per 100g'),
                                    onTap: () => context.pop(food),
                                  );
                                },
                              ),
                            ),
                          ),
                        );

                        if (selectedFood != null) {
                          final portionSize = await showDialog<double>(
                            context: context,
                            builder: (context) => BlocProvider(
                              create: (_) => PortionSizeCubit(),
                              child: const PortionSizeDialog(),
                            ),
                          );

                          if (portionSize != null && context.mounted) {
                            mealCubit.addFoodToMeal(selectedFood, portionSize);
                          }
                        }
                      },
                      child: const Text('Add Food'),
                    ),
                    const SizedBox(height: 16),
                    // List of foods added to the meal
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.selectedFoods.length,
                      itemBuilder: (context, index) {
                        final mealFood = state.selectedFoods[index];
                        return Card(
                          child: ListTile(
                            title: Text(mealFood.food.name),
                            subtitle: Text(
                              'Portion: ${mealFood.portionSize}g • ${mealFood.calories.toStringAsFixed(1)} calories',
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => mealCubit.removeFoodFromMeal(index),
                            ),
                          ),
                        );
                      },
                    ),
                    if (state.selectedFoods.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      // Shows total calories for the meal
                      Text(
                        'Total Calories: ${state.totalCalories.toStringAsFixed(1)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ],
                ),
                isActive: state.currentStep >= 0,
              ),
              Step(
                title: const Text('Name Your Meal'),
                content: TextField(
                  decoration: const InputDecoration(
                    labelText: 'Meal Name',
                    hintText: 'Enter a name for your meal',
                  ),
                  onChanged: (value) => mealCubit.updateMealName(value),
                ),
                isActive: state.currentStep >= 1,
              ),
            ],
          );
        },
      ),
    );
  }
}

// Dialog for entering portion size
