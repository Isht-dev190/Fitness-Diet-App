import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:hive/hive.dart';
import 'package:app_dev_fitness_diet/frontend/core/Models/exercise_model.dart';
import 'package:app_dev_fitness_diet/frontend/core/Models/food_model.dart';
import 'package:app_dev_fitness_diet/frontend/core/Models/article_model.dart';
import 'package:app_dev_fitness_diet/frontend/core/storage/article_storage_service.dart';

class ExerciseService extends ChangeNotifier {
  final _supabase = Supabase.instance.client;
  static const String _exerciseBoxName = 'exercises';
  bool _isLoading = false;
  String? _error;
  List<Exercise>? _exercises;

  bool get isLoading => _isLoading;
  String? get error => _error;
  List<Exercise>? get exercises => _exercises;

  Future<List<Exercise>> getExercises() async {
    try {

      final box = await Hive.openBox<Exercise>(_exerciseBoxName);
      if (box.isNotEmpty) {
        _exercises = box.values.toList();
        return _exercises!;
      }

      _isLoading = true;
      _error = null;
      notifyListeners();

      final response = await _supabase
          .rpc('get_exercises');

      if (response == null) {
        throw 'Failed to fetch exercises';
      }

      final exercisesList = (response as List<dynamic>)
          .map((json) => Exercise.fromJson(json as Map<String, dynamic>))
          .toList();

      await box.clear(); // Clear old data
      for (var exercise in exercisesList) {
        await box.add(exercise);
      }

      _exercises = exercisesList;
      return exercisesList;
    } catch (e) {
      _error = e.toString();
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> clearCache() async {
    final box = await Hive.openBox<Exercise>(_exerciseBoxName);
    await box.clear();
    _exercises = null;
    notifyListeners();
  }
}

class FoodService extends ChangeNotifier {
  final _supabase = Supabase.instance.client;
  static const String _foodBoxName = 'foods';
  bool _isLoading = false;
  String? _error;
  List<Food>? _foods;

  bool get isLoading => _isLoading;
  String? get error => _error;
  List<Food>? get foods => _foods;

  Future<List<Food>> getFoods() async {
    try {

      final box = await Hive.openBox<Food>(_foodBoxName);
      if (box.isNotEmpty) {
        _foods = box.values.toList();
        return _foods!;
      }

      _isLoading = true;
      _error = null;
      notifyListeners();

      final response = await _supabase
          .rpc('get_foods');

      if (response == null) {
        throw 'Failed to fetch foods';
      }

      final foodsList = (response as List<dynamic>)
          .map((json) => Food.fromJson(json as Map<String, dynamic>))
          .toList();

      await box.clear(); // Clear old data
      for (var food in foodsList) {
        await box.add(food);
      }

      _foods = foodsList;
      return foodsList;
    } catch (e) {
      _error = e.toString();
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> clearCache() async {
    final box = await Hive.openBox<Food>(_foodBoxName);
    await box.clear();
    _foods = null;
    notifyListeners();
  }
}

class TipsService extends ChangeNotifier {
  //final _supabase = Supabase.instance.client;
  final _storageService = ArticleStorageService();
  bool _isLoading = false;
  String? _error;
  List<Article>? _articles;

  bool get isLoading => _isLoading;
  String? get error => _error;
  List<Article>? get articles => _articles;

  Future<List<Article>> getArticles() async {
    try {
      final cachedArticles = _storageService.getAllArticles();
      if (cachedArticles.isNotEmpty) {
        _articles = cachedArticles;
        return cachedArticles;
      }

      _isLoading = true;
      _error = null;
      notifyListeners();

      await _initializeSampleArticles();
      final sampleArticles = _storageService.getAllArticles();
      _articles = sampleArticles;
      return sampleArticles;
    } catch (e) {
      _error = e.toString();
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> toggleLike(String id) async {
    await _storageService.toggleLike(id);
    _articles = _storageService.getAllArticles();
    notifyListeners();
  }

  Future<void> _initializeSampleArticles() async {
    final sampleArticles = [
      Article(
        id: '1',
        title: '10 Tips for Better Sleep',
        description: 'Learn how to improve your sleep quality with these simple tips.',
        content: 'Getting enough quality sleep is essential for your health and well-being...',
        category: 'Health',
        date: '2024-03-20',
        isLiked: false,
      ),
      Article(
        id: '2',
        title: 'Healthy Meal Prep Ideas',
        description: 'Save time and eat healthy with these meal prep strategies.',
        content: 'Meal prepping can help you stay on track with your nutrition goals...',
        category: 'Nutrition',
        date: '2024-03-19',
        isLiked: false,
      ),
      
    ];

    for (var article in sampleArticles) {
      await _storageService.saveArticle(article);
    }
  }
}
