import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_dev_fitness_diet/frontend/core/Models/workout_model.dart';
import 'package:app_dev_fitness_diet/frontend/features/workouts/add_workout_cubit.dart';
import 'package:app_dev_fitness_diet/frontend/features/workouts/exercise_selection_screen.dart';

class ExerciseSelectionStep extends StatelessWidget {
  const ExerciseSelectionStep({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddWorkoutCubit, AddWorkoutState>(
      builder: (context, state) {
        return Column(
          children: [
            if (state.selectedExercises.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  'Selected: ${state.selectedExercises.length} exercises',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ElevatedButton.icon(
              onPressed: () async {
                final result = await Navigator.push<List<WorkoutExercise>>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExerciseSelectionScreen(
                      selectedExercises: state.selectedExercises,
                      onExercisesSelected: (exercises) {
                        context.read<AddWorkoutCubit>().updateSelectedExercises(exercises);
                      },
                    ),
                  ),
                );
                if (result != null) {
                  context.read<AddWorkoutCubit>().updateSelectedExercises(result);
                }
              },
              icon: const Icon(Icons.add),
              label: Text(state.selectedExercises.isEmpty
                  ? 'Select Exercises'
                  : 'Edit Selected Exercises'),
            ),
          ],
        );
      },
    );
  }
} 