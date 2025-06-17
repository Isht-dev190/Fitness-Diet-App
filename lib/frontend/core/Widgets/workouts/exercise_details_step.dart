import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_dev_fitness_diet/frontend/features/workouts/add_workout_cubit.dart';

class ExerciseDetailsStep extends StatelessWidget {
  const ExerciseDetailsStep({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddWorkoutCubit, AddWorkoutState>(
      builder: (context, state) {
        if (state.selectedExercises.isEmpty) {
          return const Center(
            child: Text('Please select exercises first'),
          );
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: state.selectedExercises.length,
          itemBuilder: (context, index) {
            final exercise = state.selectedExercises[index];
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exercise.exerciseName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            initialValue: exercise.sets?.toString() ?? '',
                            decoration: const InputDecoration(
                              labelText: 'Sets',
                            ),
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              context.read<AddWorkoutCubit>().updateExerciseSets(index, int.tryParse(value));
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            initialValue: exercise.reps?.toString() ?? '',
                            decoration: const InputDecoration(
                              labelText: 'Reps',
                            ),
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              context.read<AddWorkoutCubit>().updateExerciseReps(index, int.tryParse(value));
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      initialValue: exercise.duration?.toString() ?? '',
                      decoration: const InputDecoration(
                        labelText: 'Duration (seconds)',
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        context.read<AddWorkoutCubit>().updateExerciseDuration(index, int.tryParse(value));
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
} 