import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_dev_fitness_diet/frontend/core/Models/workout_model.dart';

// State class for ExerciseSelectionCubit
class ExerciseSelectionState {
  final List<WorkoutExercise> selectedExercises;

  ExerciseSelectionState({
    required this.selectedExercises,
  });

  ExerciseSelectionState copyWith({
    List<WorkoutExercise>? selectedExercises,
  }) {
    return ExerciseSelectionState(
      selectedExercises: selectedExercises ?? this.selectedExercises,
    );
  }
}

// Cubit for managing exercise selection state
class ExerciseSelectionCubit extends Cubit<ExerciseSelectionState> {
  ExerciseSelectionCubit({required List<WorkoutExercise> initialExercises})
      : super(ExerciseSelectionState(selectedExercises: initialExercises));

  void toggleExercise(String exerciseName) {
    final index = state.selectedExercises.indexWhere(
      (e) => e.exerciseName == exerciseName,
    );

    final updatedExercises = List<WorkoutExercise>.from(state.selectedExercises);
    if (index >= 0) {
      updatedExercises.removeAt(index);
    } else {
      updatedExercises.add(
        WorkoutExercise(
          exerciseName: exerciseName,
          sets: 3,
          reps: 10,
        ),
      );
    }

    emit(state.copyWith(selectedExercises: updatedExercises));
  }
}

class ExerciseSelectionScreen extends StatelessWidget {
  static const List<String> _availableExercises = [
    'Push-ups',
    'Pull-ups',
    'Squats',
    'Lunges',
    'Plank',
    'Burpees',
    'Mountain Climbers',
    'Jumping Jacks',
    'Bicycle Crunches',
    'Leg Raises',
    'Dumbbell Curls',
    'Shoulder Press',
    'Deadlifts',
    'Bench Press',
    'Russian Twists',
  ];

  final List<WorkoutExercise> selectedExercises;
  final Function(List<WorkoutExercise>) onExercisesSelected;

  const ExerciseSelectionScreen({
    super.key,
    required this.selectedExercises,
    required this.onExercisesSelected,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExerciseSelectionCubit(initialExercises: selectedExercises),
      child: BlocBuilder<ExerciseSelectionCubit, ExerciseSelectionState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Select Exercises'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, state.selectedExercises);
                  },
                  child: const Text('Done'),
                ),
              ],
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Selected: ${state.selectedExercises.length} exercises',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _availableExercises.length,
                    itemBuilder: (context, index) {
                      final exercise = _availableExercises[index];
                      final isSelected = state.selectedExercises.any(
                        (e) => e.exerciseName == exercise,
                      );

                      return CheckboxListTile(
                        title: Text(exercise),
                        value: isSelected,
                        onChanged: (_) => context.read<ExerciseSelectionCubit>().toggleExercise(exercise),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
} 