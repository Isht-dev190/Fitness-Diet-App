import 'package:hive/hive.dart';
import 'package:app_dev_fitness_diet/frontend/core/Models/article_model.dart';
import 'package:app_dev_fitness_diet/frontend/core/storage/base_storage_service.dart';

class ArticleStorageService extends BaseStorageService<Article> {
  static const String _boxName = 'articles';

  ArticleStorageService() : super(_boxName);

  Future<void> saveArticle(Article article) async {
    await add(article.id, article);
  }

  Future<void> updateArticle(Article article) async {
    await update(article.id, article);
  }

  Article? getArticle(String id) {
    return get(id);
  }

  List<Article> getArticlesByCategory(String category) {
    return getAll().where((article) => article.category == category).toList();
  }

  Future<void> deleteArticle(String id) async {
    await delete(id);
  }

  List<Article> getAllArticles() {
    return getAll();
  }

  bool articleExists(String id) {
    return exists(id);
  }

  Stream<BoxEvent> watchArticles({String? id}) {
    return watch(key: id);
  }

  Future<void> saveAllArticles(List<Article> articles) async {
    final articleMap = {
      for (var article in articles) article.id: article
    };
    await addAll(articleMap);
  }

  List<Article> getLikedArticles() {
    return getAll().where((article) => article.isLiked).toList();
  }

  Future<void> toggleLike(String id) async {
    final article = get(id);
    if (article != null) {
      article.isLiked = !article.isLiked;
      await update(id, article);
    }
  }
} 