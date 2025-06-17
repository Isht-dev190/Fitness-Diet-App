import 'package:hive/hive.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_dev_fitness_diet/frontend/core/Models/workout_model.dart';

// State class for WorkoutServiceCubit
class WorkoutServiceState {
  final bool isLoading;
  final String? error;
  final List<Workout> workouts;

  WorkoutServiceState({
    this.isLoading = false,
    this.error,
    this.workouts = const [],
  });

  WorkoutServiceState copyWith({
    bool? isLoading,
    String? error,
    List<Workout>? workouts,
  }) {
    return WorkoutServiceState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      workouts: workouts ?? this.workouts,
    );
  }
}

// Cubit for managing workout service state
class WorkoutServiceCubit extends Cubit<WorkoutServiceState> {
  final Box<Workout> _workoutBox;

  WorkoutServiceCubit(this._workoutBox) : super(WorkoutServiceState()) {
    print('WorkoutServiceCubit initialized with box: ${_workoutBox.name}');
    // Load workouts immediately when cubit is created
    getWorkouts();
  }

  Future<void> getWorkouts() async {
    print('Getting workouts from Hive box...');
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final workouts = _workoutBox.values.toList();
      print('Found ${workouts.length} workouts in Hive box');
      for (var workout in workouts) {
        print('Workout: ${workout.name}, Exercises: ${workout.exercises.length}');
      }
      emit(state.copyWith(
        isLoading: false,
        workouts: workouts,
      ));
    } catch (e) {
      print('Error getting workouts: $e');
      emit(state.copyWith(
        isLoading: false,
        error: 'Failed to load workouts',
      ));
    }
  }

  Future<void> saveWorkout(Workout workout) async {
    print('Saving workout: ${workout.name}');
    print('Workout details:');
    print('- ID: ${workout.id}');
    print('- Exercises: ${workout.exercises.length}');
    print('- Scheduled dates: ${workout.scheduledDates.length}');
    print('- Time: ${workout.time.hour}:${workout.time.minute}');
    
    emit(state.copyWith(isLoading: true, error: null));

    try {
      await _workoutBox.put(workout.id, workout);
      print('Workout saved successfully');
      final workouts = _workoutBox.values.toList();
      print('Total workouts in box: ${workouts.length}');
      emit(state.copyWith(
        isLoading: false,
        workouts: workouts,
      ));
    } catch (e) {
      print('Error saving workout: $e');
      emit(state.copyWith(
        isLoading: false,
        error: 'Failed to save workout',
      ));
    }
  }

  Future<void> deleteWorkout(String id) async {
    print('Deleting workout with ID: $id');
    emit(state.copyWith(isLoading: true, error: null));

    try {
      await _workoutBox.delete(id);
      print('Workout deleted successfully');
      final workouts = _workoutBox.values.toList();
      print('Remaining workouts: ${workouts.length}');
      emit(state.copyWith(
        isLoading: false,
        workouts: workouts,
      ));
    } catch (e) {
      print('Error deleting workout: $e');
      emit(state.copyWith(
        isLoading: false,
        error: 'Failed to delete workout',
      ));
    }
  }

  Future<void> toggleNotifications(String id) async {
    print('Toggling notifications for workout ID: $id');
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final workout = _workoutBox.get(id);
      if (workout != null) {
        print('Found workout: ${workout.name}');
        final updatedWorkout = workout.copyWith(
          notificationsEnabled: !workout.notificationsEnabled,
        );
        await _workoutBox.put(id, updatedWorkout);
        print('Notifications toggled to: ${updatedWorkout.notificationsEnabled}');
        final workouts = _workoutBox.values.toList();
        emit(state.copyWith(
          isLoading: false,
          workouts: workouts,
        ));
      } else {
        print('Workout not found with ID: $id');
      }
    } catch (e) {
      print('Error toggling notifications: $e');
      emit(state.copyWith(
        isLoading: false,
        error: 'Failed to toggle notifications',
      ));
    }
  }
} 