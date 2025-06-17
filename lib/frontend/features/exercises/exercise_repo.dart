import 'package:dartz/dartz.dart';
import 'package:app_dev_fitness_diet/frontend/core/Models/exercise_model.dart';
import 'package:app_dev_fitness_diet/frontend/core/error/failures.dart';
import '../Service.dart';

class ExerciseRepository {
  final ExerciseService _exerciseService;

  ExerciseRepository(this._exerciseService);

  Future<Either<Failure, List<Exercise>>> getExercises() async {
    try {
      final exercises = await _exerciseService.getExercises();
      return Right(exercises);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
