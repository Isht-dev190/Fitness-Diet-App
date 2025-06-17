import 'package:flutter/material.dart';
import 'package:app_dev_fitness_diet/frontend/core/Models/article_model.dart';
import 'package:app_dev_fitness_diet/frontend/features/Tips/tips_repo.dart';

class TipsViewModel extends ChangeNotifier {
  final TipsRepository _repository;
  bool _isLoading = false;
  String? _error;
  List<Article> _articles = [];
  List<Article> _filteredArticles = [];
  String _searchQuery = '';
  String _selectedCategory = 'All';
  bool _showLikedOnly = false;

  TipsViewModel(this._repository) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadArticles();
    });
  }

  bool get isLoading => _isLoading;
  String? get error => _error;
  List<Article> get articles => _filteredArticles;
  String get searchQuery => _searchQuery;
  String get selectedCategory => _selectedCategory;
  bool get showLikedOnly => _showLikedOnly;

  List<String> get categories {
    final categories = _articles.map((a) => a.category).toSet().toList();
    categories.insert(0, 'All');
    return categories;
  }

  Future<void> _loadArticles() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final result = await _repository.getArticles();
      result.fold(
        (failure) {
          _error = failure.message;
          _articles = [];
        },
        (articles) {
          _articles = articles;
          _error = null;
          _filterArticles();
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
    _filterArticles();
    notifyListeners();
  }

  void updateSelectedCategory(String category) {
    _selectedCategory = category;
    _filterArticles();
    notifyListeners();
  }

  void toggleShowLikedOnly() {
    _showLikedOnly = !_showLikedOnly;
    _filterArticles();
    notifyListeners();
  }

  void _filterArticles() {
    _filteredArticles = _articles.where((article) {
      final matchesSearch = article.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          article.description.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesCategory = _selectedCategory == 'All' || article.category == _selectedCategory;
      final matchesLiked = !_showLikedOnly || article.isLiked;
      return matchesSearch && matchesCategory && matchesLiked;
    }).toList();
  }

  Future<void> toggleLike(String id) async {
    final result = await _repository.toggleLike(id);
    result.fold(
      (failure) {
        _error = failure.message;
        notifyListeners();
      },
      (_) {
        _loadArticles();
      },
    );
  }

  void refreshArticles() {
    _loadArticles();
  }
}
