import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_dev_fitness_diet/frontend/core/Models/workout_model.dart';
import 'package:flutter/material.dart';

// State class for the AddWorkoutCubit
class AddWorkoutState {
  final TimeOfDay selectedTime;
  final List<DateTime> selectedDates;
  final List<WorkoutExercise> selectedExercises;
  final int currentStep;
  final String workoutName;

  AddWorkoutState({
    this.selectedTime = const TimeOfDay(hour: 0, minute: 0),
    this.selectedDates = const [],
    this.selectedExercises = const [],
    this.currentStep = 0,
    this.workoutName = '',
  });

  AddWorkoutState copyWith({
    TimeOfDay? selectedTime,
    List<DateTime>? selectedDates,
    List<WorkoutExercise>? selectedExercises,
    int? currentStep,
    String? workoutName,
  }) {
    return AddWorkoutState(
      selectedTime: selectedTime ?? this.selectedTime,
      selectedDates: selectedDates ?? this.selectedDates,
      selectedExercises: selectedExercises ?? this.selectedExercises,
      currentStep: currentStep ?? this.currentStep,
      workoutName: workoutName ?? this.workoutName,
    );
  }
}

// Cubit class for managing add workout state
class AddWorkoutCubit extends Cubit<AddWorkoutState> {
  AddWorkoutCubit() : super(AddWorkoutState());

  void updateSelectedTime(TimeOfDay time) {
    emit(state.copyWith(selectedTime: time));
  }

  void updateSelectedDates(List<DateTime> dates) {
    emit(state.copyWith(selectedDates: dates));
  }

  void updateSelectedExercises(List<WorkoutExercise> exercises) {
    emit(state.copyWith(selectedExercises: exercises));
  }

  void updateCurrentStep(int step) {
    emit(state.copyWith(currentStep: step));
  }

  void updateWorkoutName(String name) {
    emit(state.copyWith(workoutName: name));
  }

  void updateExerciseSets(int index, int? sets) {
    final updatedExercises = List<WorkoutExercise>.from(state.selectedExercises);
    updatedExercises[index] = updatedExercises[index].copyWith(sets: sets);
    emit(state.copyWith(selectedExercises: updatedExercises));
  }

  void updateExerciseReps(int index, int? reps) {
    final updatedExercises = List<WorkoutExercise>.from(state.selectedExercises);
    updatedExercises[index] = updatedExercises[index].copyWith(reps: reps);
    emit(state.copyWith(selectedExercises: updatedExercises));
  }

  void updateExerciseDuration(int index, int? duration) {
    final updatedExercises = List<WorkoutExercise>.from(state.selectedExercises);
    updatedExercises[index] = updatedExercises[index].copyWith(duration: duration);
    emit(state.copyWith(selectedExercises: updatedExercises));
  }
} 