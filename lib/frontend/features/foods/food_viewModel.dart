import 'package:flutter/material.dart';
import 'package:app_dev_fitness_diet/frontend/core/Models/food_model.dart';
import 'package:app_dev_fitness_diet/frontend/features/foods/food_repo.dart';

class FoodViewModel extends ChangeNotifier {
  final FoodRepository _foodRepository;
  bool _isLoading = false;
  String? _error;
  List<Food> _foods = [];
  String _searchQuery = '';

  FoodViewModel(this._foodRepository) {
    _loadFoods();
  }

  bool get isLoading => _isLoading;
  String? get error => _error;
  List<Food> get foods => _foods;
  String get searchQuery => _searchQuery;

  List<Food> get filteredFoods {
    if (_searchQuery.isEmpty) {
      return _foods;
    }
    return _foods.where((food) {
      final name = food.name.toLowerCase();
      final category = food.category.toLowerCase();
      final description = food.description.toLowerCase();
      final query = _searchQuery.toLowerCase();
      return name.contains(query) ||
          category.contains(query) ||
          description.contains(query);
    }).toList();
  }

  Future<void> _loadFoods() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final result = await _foodRepository.getFoods();
      result.fold(
        (failure) {
          _error = failure.message;
        },
        (foods) {
          _foods = foods;
        },
      );
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  Future<void> refreshFoods() async {
    await _loadFoods();
  }

  Food? getFoodByName(String name) {
    try {
      return _foods.firstWhere((food) => food.name == name);
    } catch (e) {
      return null;
    }
  }
} 