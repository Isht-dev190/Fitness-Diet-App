import 'package:app_dev_fitness_diet/frontend/core/Dependencies/initDependencies.dart';
import 'package:app_dev_fitness_diet/frontend/core/Models/meal_model.dart';
import 'package:app_dev_fitness_diet/frontend/core/storage/base_storage_service.dart';
import 'package:hive/hive.dart';

class MealStorageService extends BaseStorageService<Meal> {
  static final MealStorageService _instance = MealStorageService._internal();
  
  factory MealStorageService() {
    return _instance;
  }
  
  MealStorageService._internal() : super(HiveInitializer.mealBoxName);

  Future<void> saveMeal(Meal meal) async {
    await add(meal.id, meal);
  }

  Future<void> updateMeal(Meal meal) async {
    await update(meal.id, meal);
  }

  Meal? getMeal(String id) {
    return get(id);
  }

  List<Meal> getUserMeals(String userEmail) {
    return getAll().where((meal) => meal.userEmail == userEmail).toList();
  }

  Future<void> deleteMeal(String id) async {
    await delete(id);
  }

  Future<void> deleteUserMeals(String userEmail) async {
    final userMeals = getUserMeals(userEmail);
    for (final meal in userMeals) {
      await delete(meal.id);
    }
  }

  List<Meal> getAllMeals() {
    return getAll();
  }

  bool mealExists(String id) {
    return exists(id);
  }

  Stream<BoxEvent> watchUserMeals(String userEmail) {
    return watch();
  }
} 