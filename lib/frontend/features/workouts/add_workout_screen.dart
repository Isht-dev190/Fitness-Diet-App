import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_dev_fitness_diet/frontend/features/workouts/workout_cubit.dart';
import 'package:app_dev_fitness_diet/frontend/features/workouts/add_workout_cubit.dart';
import 'package:app_dev_fitness_diet/frontend/core/Models/workout_model.dart';
import 'package:app_dev_fitness_diet/frontend/core/Widgets/workouts/exercise_selection_step.dart';
import 'package:app_dev_fitness_diet/frontend/core/Widgets/workouts/exercise_details_step.dart';
import 'package:app_dev_fitness_diet/frontend/core/Widgets/workouts/workout_details_step.dart';
import 'package:go_router/go_router.dart';

class AddWorkoutScreen extends StatelessWidget {
  const AddWorkoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return BlocBuilder<AddWorkoutCubit, AddWorkoutState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Add Workout'),
          ),
          body: Form(
            key: formKey,
            child: Stepper(
              currentStep: state.currentStep,
              onStepContinue: () {
                if (state.currentStep < 2) {
                  context.read<AddWorkoutCubit>().updateCurrentStep(state.currentStep + 1);
                } else {
                  _saveWorkout(context, state, formKey);
                }
              },
              onStepCancel: () {
                if (state.currentStep > 0) {
                  context.read<AddWorkoutCubit>().updateCurrentStep(state.currentStep - 1);
                } else {
                  context.pop();
                }
              },
              steps: [
                Step(
                  title: const Text('Select Exercises'),
                  content: const ExerciseSelectionStep(),
                  isActive: state.currentStep >= 0,
                ),
                Step(
                  title: const Text('Exercise Details'),
                  content: const ExerciseDetailsStep(),
                  isActive: state.currentStep >= 1,
                ),
                Step(
                  title: const Text('Workout Details'),
                  content: const WorkoutDetailsStep(),
                  isActive: state.currentStep >= 2,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _saveWorkout(BuildContext context, AddWorkoutState state, GlobalKey<FormState> formKey) {
    if (formKey.currentState?.validate() ?? false) {
      if (state.selectedExercises.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select at least one exercise')),
        );
        return;
      }

      if (state.workoutName.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter a workout name')),
        );
        return;
      }

      final workout = Workout.fromTimeOfDay(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: state.workoutName,
        exercises: state.selectedExercises,
        scheduledDates: state.selectedDates,
        time: state.selectedTime,
        userEmail: 'user@example.com', 
        notificationsEnabled: true,
      );

      context.read<WorkoutCubit>().saveWorkout(workout);
      context.pop();
    }
  }
} 