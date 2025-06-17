import 'package:flutter/material.dart';
import 'package:app_dev_fitness_diet/frontend/core/Models/workout_model.dart';

class WorkoutDetailsModal extends StatelessWidget {
  final Workout workout;
  final ScrollController scrollController;

  const WorkoutDetailsModal({
    super.key,
    required this.workout,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            workout.name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Time: ${workout.time.format(context)}',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            'Days: ${workout.scheduledDates.map((date) => _getDayName(date.weekday)).join(', ')}',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 24),
          const Text(
            'Exercises',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: workout.exercises.length,
              itemBuilder: (context, index) {
                final exercise = workout.exercises[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    title: Text(exercise.exerciseName),
                    subtitle: Text(
                      'Sets: ${exercise.sets}, Reps: ${exercise.reps}, Duration: ${exercise.duration}',
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _getDayName(int weekday) {
    switch (weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }
} 