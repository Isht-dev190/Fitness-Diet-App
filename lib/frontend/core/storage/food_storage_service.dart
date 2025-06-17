import 'package:app_dev_fitness_diet/frontend/core/Models/food_model.dart';
import 'package:app_dev_fitness_diet/frontend/core/storage/base_storage_service.dart';
import 'package:hive/hive.dart';

class FoodStorageService extends BaseStorageService<Food> {
  static const String _boxName = 'foods';

  FoodStorageService() : super(_boxName);

  Future<void> saveFood(Food food) async {
    await add(food.name, food);
  }

  Future<void> updateFood(Food food) async {
    await update(food.name, food);
  }

  Food? getFood(String name) {
    return get(name);
  }

  List<Food> getFoodsByCategory(String category) {
    return getAll().where((food) => food.category == category).toList();
  }

  Future<void> deleteFood(String name) async {
    await delete(name);
  }

  List<Food> getAllFoods() {
    return getAll();
  }

  bool foodExists(String name) {
    return exists(name);
  }

  Stream<BoxEvent> watchFoods() {
    return watch();
  }

  Future<void> saveAllFoods(List<Food> foods) async {
    final foodMap = {for (var food in foods) food.name: food};
    await addAll(foodMap);
  }

  List<Food> searchFoods(String query) {
    return getAll().where((food) {
      final name = food.name.toLowerCase();
      final category = food.category.toLowerCase();
      final description = food.description.toLowerCase();
      final searchQuery = query.toLowerCase();
      
      return name.contains(searchQuery) ||
          category.contains(searchQuery) ||
          description.contains(searchQuery);
    }).toList();
  }
} 