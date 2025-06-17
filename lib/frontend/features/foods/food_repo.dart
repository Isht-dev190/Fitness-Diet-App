import 'package:dartz/dartz.dart';
import 'package:app_dev_fitness_diet/frontend/core/Models/food_model.dart';
import 'package:app_dev_fitness_diet/frontend/features/Service.dart';
import 'package:app_dev_fitness_diet/frontend/core/error/failures.dart';

class FoodRepository {
  final FoodService _foodService;

  FoodRepository(this._foodService);

  Future<Either<Failure, List<Food>>> getFoods() async {
    try {
      final foods = await _foodService.getFoods();
      return Right(foods);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
