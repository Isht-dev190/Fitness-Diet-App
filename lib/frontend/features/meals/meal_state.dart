
import 'package:app_dev_fitness_diet/frontend/core/Models/meal_model.dart';


class MealState {
  final List<Meal> meals;
  final bool isLoading;
  final String? error;
  final List<MealFood> selectedFoods;
  final String mealName;
  final int currentStep;

  MealState({
    this.meals = const [],
    this.isLoading = false,
    this.error,
    this.selectedFoods = const [],
    this.mealName = '',
    this.currentStep = 0,
  });

  MealState copyWith({
    List<Meal>? meals,
    bool? isLoading,
    String? error,
    List<MealFood>? selectedFoods,
    String? mealName,
    int? currentStep,
  }) {
    return MealState(
      meals: meals ?? this.meals,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      selectedFoods: selectedFoods ?? this.selectedFoods,
      mealName: mealName ?? this.mealName,
      currentStep: currentStep ?? this.currentStep,
    );
  }

  double get totalCalories => selectedFoods.fold(0, (sum, food) => sum + food.calories);
}
