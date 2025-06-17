import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_dev_fitness_diet/frontend/core/Models/workout_model.dart';
import 'package:app_dev_fitness_diet/frontend/features/workouts/workout_repository.dart';

// State classes for the WorkoutCubit
sealed class WorkoutState {}

class WorkoutInitial extends WorkoutState {}

class WorkoutLoading extends WorkoutState {}

class WorkoutError extends WorkoutState {
  final String message;

  WorkoutError(this.message);
}

class WorkoutLoaded extends WorkoutState {
  final List<Workout> workouts;

  WorkoutLoaded(this.workouts);
}

// Cubit class for managing workout state
class WorkoutCubit extends Cubit<WorkoutState> {
  final WorkoutRepository _repository;

  WorkoutCubit(this._repository) : super(WorkoutInitial());

  Future<void> loadWorkouts() async {
    emit(WorkoutLoading());

    try {
      final result = await _repository.getWorkouts();
      result.fold(
        (failure) {
          emit(WorkoutError(failure.message));
        },
        (workouts) {
          emit(WorkoutLoaded(workouts));
        },
      );
    } catch (e) {
      emit(WorkoutError(e.toString()));
    }
  }

  Future<void> saveWorkout(Workout workout) async {
    emit(WorkoutLoading());

    try {
      final result = await _repository.saveWorkout(workout);
      result.fold(
        (failure) {
          emit(WorkoutError(failure.message));
        },
        (_) {
          loadWorkouts();
        },
      );
    } catch (e) {
      emit(WorkoutError(e.toString()));
    }
  }

  Future<void> deleteWorkout(String id) async {
    emit(WorkoutLoading());

    try {
      final result = await _repository.deleteWorkout(id);
      result.fold(
        (failure) {
          emit(WorkoutError(failure.message));
        },
        (_) {
          loadWorkouts();
        },
      );
    } catch (e) {
      emit(WorkoutError(e.toString()));
    }
  }

  Future<void> toggleNotifications(String id) async {
    try {
      final result = await _repository.toggleNotifications(id);
      result.fold(
        (failure) {
          emit(WorkoutError(failure.message));
        },
        (_) {
          loadWorkouts();
        },
      );
    } catch (e) {
      emit(WorkoutError(e.toString()));
    }
  }
} 