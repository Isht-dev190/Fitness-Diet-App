import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_dev_fitness_diet/frontend/features/workouts/workout_cubit.dart';
import 'package:app_dev_fitness_diet/frontend/features/workouts/add_workout_cubit.dart';
import 'package:app_dev_fitness_diet/frontend/core/Models/workout_model.dart';
import 'package:app_dev_fitness_diet/frontend/features/workouts/exercise_selection_screen.dart';

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
                  Navigator.pop(context);
                }
              },
              steps: [
                Step(
                  title: const Text('Select Exercises'),
                  content: _buildExerciseSelection(context, state),
                  isActive: state.currentStep >= 0,
                ),
                Step(
                  title: const Text('Exercise Details'),
                  content: _buildExerciseDetails(state),
                  isActive: state.currentStep >= 1,
                ),
                Step(
                  title: const Text('Workout Details'),
                  content: _buildWorkoutDetails(context, state),
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
      Navigator.pop(context);
    }
  }

  Widget _buildExerciseSelection(BuildContext context, AddWorkoutState state) {
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
  }

  Widget _buildExerciseDetails(AddWorkoutState state) {
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
  }

  Widget _buildWorkoutDetails(BuildContext context, AddWorkoutState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Workout Name',
          ),
          initialValue: state.workoutName,
          onChanged: (value) {
            context.read<AddWorkoutCubit>().updateWorkoutName(value);
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a workout name';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        ListTile(
          title: const Text('Time'),
          subtitle: Text(state.selectedTime.format(context)),
          trailing: const Icon(Icons.access_time),
          onTap: () async {
            final TimeOfDay? picked = await showTimePicker(
              context: context,
              initialTime: state.selectedTime,
            );
            if (picked != null && picked != state.selectedTime) {
              context.read<AddWorkoutCubit>().updateSelectedTime(picked);
            }
          },
        ),
        ListTile(
          title: const Text('Days'),
          subtitle: Text(state.selectedDates.isEmpty
              ? 'No days selected'
              : state.selectedDates
                  .map((date) => _getDayName(date.weekday))
                  .join(', ')),
          trailing: const Icon(Icons.calendar_today),
          onTap: () async {
            final DateTimeRange? picked = await showDateRangePicker(
              context: context,
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 365)),
              initialDateRange: state.selectedDates.isEmpty
                  ? null
                  : DateTimeRange(
                      start: state.selectedDates.first,
                      end: state.selectedDates.last,
                    ),
            );
            if (picked != null) {
              context.read<AddWorkoutCubit>().updateSelectedDates(
                    _getDatesInRange(picked.start, picked.end),
                  );
            }
          },
        ),
      ],
    );
  }

  List<DateTime> _getDatesInRange(DateTime start, DateTime end) {
    final List<DateTime> dates = [];
    var current = start;
    while (!current.isAfter(end)) {
      dates.add(current);
      current = current.add(const Duration(days: 1));
    }
    return dates;
  }

  String _getDayName(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return 'Mon';
      case DateTime.tuesday:
        return 'Tue';
      case DateTime.wednesday:
        return 'Wed';
      case DateTime.thursday:
        return 'Thu';
      case DateTime.friday:
        return 'Fri';
      case DateTime.saturday:
        return 'Sat';
      case DateTime.sunday:
        return 'Sun';
      default:
        return '';
    }
  }
} 