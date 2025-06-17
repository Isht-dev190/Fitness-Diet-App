import 'package:hive/hive.dart';
import 'package:app_dev_fitness_diet/frontend/core/Models/food_model.dart';

part 'meal_model.g.dart';

@HiveType(typeId: 7)
class MealFood {
  @HiveField(0)
  final Food food;

  @HiveField(1)
  final double portionSize; // in grams or units

  @HiveField(2)
  final double calories; // calculated based on portion size

  MealFood({
    required this.food,
    required this.portionSize,
    required this.calories,
  });

  factory MealFood.fromFood({
    required Food food,
    required double portionSize,
  }) {
    // Calculate calories based on portion size
    final caloriesPer100g = food.calories;
    final calories = (caloriesPer100g * portionSize) / 100;

    return MealFood(
      food: food,
      portionSize: portionSize,
      calories: calories,
    );
  }

  MealFood copyWith({
    Food? food,
    double? portionSize,
    double? calories,
  }) {
    return MealFood(
      food: food ?? this.food,
      portionSize: portionSize ?? this.portionSize,
      calories: calories ?? this.calories,
    );
  }
}

@HiveType(typeId: 8)
class Meal {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final List<MealFood> foods;

  @HiveField(3)
  final DateTime createdAt;

  @HiveField(4)
  final String userEmail;

  double get totalCalories => foods.fold(0, (sum, food) => sum + food.calories);

  Meal({
    required this.id,
    required this.name,
    required this.foods,
    required this.userEmail,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Meal copyWith({
    String? id,
    String? name,
    List<MealFood>? foods,
    String? userEmail,
    DateTime? createdAt,
  }) {
    return Meal(
      id: id ?? this.id,
      name: name ?? this.name,
      foods: foods ?? this.foods,
      userEmail: userEmail ?? this.userEmail,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
