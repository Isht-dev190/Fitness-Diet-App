import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_dev_fitness_diet/frontend/core/Models/workout_model.dart';
import 'package:app_dev_fitness_diet/frontend/features/workouts/workout_repository.dart';

// State class for the WorkoutCubit
class WorkoutState {
  final bool isLoading;
  final String? error;
  final List<Workout> workouts;

  WorkoutState({
    this.isLoading = false,
    this.error,
    this.workouts = const [],
  });

  WorkoutState copyWith({
    bool? isLoading,
    String? error,
    List<Workout>? workouts,
  }) {
    return WorkoutState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      workouts: workouts ?? this.workouts,
    );
  }
}

// Cubit class for managing workout state
class WorkoutCubit extends Cubit<WorkoutState> {
  final WorkoutRepository _repository;

  WorkoutCubit(this._repository) : super(WorkoutState());

  Future<void> loadWorkouts() async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final result = await _repository.getWorkouts();
      result.fold(
        (failure) {
          emit(state.copyWith(
            isLoading: false,
            error: failure.message,
            workouts: [],
          ));
        },
        (workouts) {
          emit(state.copyWith(
            isLoading: false,
            workouts: workouts,
          ));
        },
      );
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> saveWorkout(Workout workout) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final result = await _repository.saveWorkout(workout);
      result.fold(
        (failure) {
          emit(state.copyWith(
            isLoading: false,
            error: failure.message,
          ));
        },
        (_) {
          loadWorkouts();
        },
      );
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> deleteWorkout(String id) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final result = await _repository.deleteWorkout(id);
      result.fold(
        (failure) {
          emit(state.copyWith(
            isLoading: false,
            error: failure.message,
          ));
        },
        (_) {
          loadWorkouts();
        },
      );
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> toggleNotifications(String id) async {
    try {
      final result = await _repository.toggleNotifications(id);
      result.fold(
        (failure) {
          emit(state.copyWith(
            error: failure.message,
          ));
        },
        (_) {
          loadWorkouts();
        },
      );
    } catch (e) {
      emit(state.copyWith(
        error: e.toString(),
      ));
    }
  }
} 