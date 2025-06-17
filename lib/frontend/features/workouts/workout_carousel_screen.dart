import 'package:app_dev_fitness_diet/frontend/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_dev_fitness_diet/frontend/features/workouts/workout_cubit.dart';
import 'package:app_dev_fitness_diet/frontend/core/Models/workout_model.dart';
import 'package:app_dev_fitness_diet/frontend/features/workouts/add_workout_screen.dart';
import 'package:provider/provider.dart';
import 'package:app_dev_fitness_diet/frontend/core/theme/theme_provider.dart';

class WorkoutCarouselScreen extends StatelessWidget {
  const WorkoutCarouselScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;
    final textColor = isDark ? Colors.white : Colors.black;

    return BlocBuilder<WorkoutCubit, WorkoutState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.error != null) {
          return Center(child: Text('Error: ${state.error}'));
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppPallete.primaryColor, width: 2.0),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: PageView(
              children: [
                _buildAddWorkoutPage(context, textColor),
                _buildWorkoutListPage(context, state.workouts),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAddWorkoutPage(BuildContext context, Color textColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Add a New Workout',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton.icon(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddWorkoutScreen(),
                  ),
                );
                if (context.mounted) {
                  context.read<WorkoutCubit>().loadWorkouts();
                }
              },
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text(
                'Add a Workout',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppPallete.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkoutListPage(BuildContext context, List<Workout> workouts) {
    if (workouts.isEmpty) {
      return const Center(
        child: Text('No workouts yet. Add your first workout!'),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: workouts.length,
      itemBuilder: (context, index) {
        final workout = workouts[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
            side: const BorderSide(color: AppPallete.primaryColor),
          ),
          child: InkWell(
            onTap: () => _showWorkoutDetails(context, workout),
            borderRadius: BorderRadius.circular(12.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          workout.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          workout.notificationsEnabled ? Icons.notifications_active : Icons.notifications_off,
                          color: workout.notificationsEnabled ? AppPallete.primaryColor : Colors.grey,
                        ),
                        onPressed: () {
                          context.read<WorkoutCubit>().toggleNotifications(workout.id);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Time: ${workout.time.format(context)}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    'Days: ${workout.scheduledDates.map((date) => _getDayName(date.weekday)).join(', ')}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    'Exercises: ${workout.exercises.length}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showWorkoutDetails(BuildContext context, Workout workout) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        expand: false,
        builder: (context, scrollController) => Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: AppPallete.primaryColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    workout.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: workout.exercises.length,
                itemBuilder: (context, index) {
                  final exercise = workout.exercises[index];
                  return Card(
                    margin: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            exercise.exerciseName,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          if (exercise.sets != null)
                            Text('Sets: ${exercise.sets}'),
                          if (exercise.reps != null)
                            Text('Reps: ${exercise.reps}'),
                          if (exercise.duration != null)
                            Text('Duration: ${exercise.duration} seconds'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
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