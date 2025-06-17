import 'package:dartz/dartz.dart';
import 'package:app_dev_fitness_diet/frontend/core/Models/workout_model.dart';
import 'package:app_dev_fitness_diet/frontend/features/workouts/workout_service.dart';
import 'package:app_dev_fitness_diet/frontend/core/error/failures.dart';

class WorkoutRepository {
  final WorkoutServiceCubit _workoutService;

  WorkoutRepository(this._workoutService);

  Future<Either<Failure, List<Workout>>> getWorkouts() async {
    try {
      await _workoutService.getWorkouts();
      return Right(_workoutService.state.workouts);
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to load workouts'));
    }
  }

  Future<Either<Failure, void>> saveWorkout(Workout workout) async {
    try {
      await _workoutService.saveWorkout(workout);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to save workout'));
    }
  }

  Future<Either<Failure, void>> deleteWorkout(String id) async {
    try {
      await _workoutService.deleteWorkout(id);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to delete workout'));
    }
  }

  Future<Either<Failure, void>> toggleNotifications(String id) async {
    try {
      await _workoutService.toggleNotifications(id);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to toggle notifications'));
    }
  }
} 