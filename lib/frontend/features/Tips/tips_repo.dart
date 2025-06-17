import 'package:dartz/dartz.dart';
import 'package:app_dev_fitness_diet/frontend/core/Models/article_model.dart';
import 'package:app_dev_fitness_diet/frontend/features/Service.dart';
import 'package:app_dev_fitness_diet/frontend/core/error/failures.dart';

class TipsRepository {
  final TipsService _service;

  TipsRepository(this._service);

  Future<Either<Failure, List<Article>>> getArticles() async {
    try {
      final articles = await _service.getArticles();
      return Right(articles);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, void>> toggleLike(String id) async {
    try {
      await _service.toggleLike(id);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
} 