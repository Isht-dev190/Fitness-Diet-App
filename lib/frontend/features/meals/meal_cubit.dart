import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_dev_fitness_diet/frontend/core/Models/meal_model.dart';
import 'package:app_dev_fitness_diet/frontend/core/Models/food_model.dart';
import 'package:hive/hive.dart';
import 'package:app_dev_fitness_diet/frontend/features/meals/meal_state.dart';

class MealCubit extends Cubit<MealState> {
  final Box<Meal> _mealBox;

  MealCubit(this._mealBox) : super(MealState()) {
    loadMeals();
  }

  Future<void> loadMeals() async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final meals = _mealBox.values.toList();
      print('Loaded ${meals.length} meals from Hive');
      emit(state.copyWith(
        isLoading: false,
        meals: meals,
      ));
    } catch (e) {
      print('Error loading meals: $e');
      emit(state.copyWith(
        isLoading: false,
        error: 'Failed to load meals',
      ));
    }
  }

  void updateMealName(String name) {
    emit(state.copyWith(mealName: name));
  }

  void updateCurrentStep(int step) {
    emit(state.copyWith(currentStep: step));
  }

  void addFoodToMeal(Food food, double portionSize) {
    final mealFood = MealFood.fromFood(
      food: food,
      portionSize: portionSize,
    );

    final updatedFoods = List<MealFood>.from(state.selectedFoods)..add(mealFood);
    emit(state.copyWith(selectedFoods: updatedFoods));
  }

  void removeFoodFromMeal(int index) {
    final updatedFoods = List<MealFood>.from(state.selectedFoods)..removeAt(index);
    emit(state.copyWith(selectedFoods: updatedFoods));
  }

  void updatePortionSize(int index, double newPortionSize) {
    final food = state.selectedFoods[index];
    final updatedFood = MealFood.fromFood(
      food: food.food,
      portionSize: newPortionSize,
    );

    final updatedFoods = List<MealFood>.from(state.selectedFoods)
      ..[index] = updatedFood;
    emit(state.copyWith(selectedFoods: updatedFoods));
  }

  Future<void> saveMeal(String userEmail) async {
    if (state.mealName.isEmpty) {
      emit(state.copyWith(error: 'Please enter a meal name'));
      return;
    }

    if (state.selectedFoods.isEmpty) {
      emit(state.copyWith(error: 'Please add at least one food to the meal'));
      return;
    }

    emit(state.copyWith(isLoading: true, error: null));

    try {
      final meal = Meal(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: state.mealName,
        foods: state.selectedFoods,
        userEmail: userEmail,
      );

      await _mealBox.put(meal.id, meal);
      print('Saved meal: ${meal.name} with ${meal.foods.length} foods');

      // Reset state and reload meals
      emit(state.copyWith(
        isLoading: false,
        mealName: '',
        selectedFoods: [],
        currentStep: 0,
      ));
      loadMeals();
    } catch (e) {
      print('Error saving meal: $e');
      emit(state.copyWith(
        isLoading: false,
        error: 'Failed to save meal',
      ));
    }
  }

  Future<void> deleteMeal(String id) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      await _mealBox.delete(id);
      print('Deleted meal with id: $id');
      loadMeals();
    } catch (e) {
      print('Error deleting meal: $e');
      emit(state.copyWith(
        isLoading: false,
        error: 'Failed to delete meal',
      ));
    }
  }
} 