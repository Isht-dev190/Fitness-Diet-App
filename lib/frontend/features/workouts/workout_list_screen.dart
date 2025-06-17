import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_dev_fitness_diet/frontend/features/workouts/workout_cubit.dart';
import 'package:app_dev_fitness_diet/frontend/core/Models/workout_model.dart';
import 'package:app_dev_fitness_diet/frontend/core/theme/app_pallete.dart';
import 'package:provider/provider.dart';
import 'package:app_dev_fitness_diet/frontend/core/theme/theme_provider.dart';
import 'package:app_dev_fitness_diet/frontend/core/Widgets/workout_card.dart';
import 'package:go_router/go_router.dart';

class WorkoutListScreen extends StatelessWidget {
  const WorkoutListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<WorkoutCubit>().loadWorkouts();

    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;
    final backgroundColor = isDark ? AppPallete.darkBgColor : AppPallete.lightBgColor;
    final textColor = isDark ? AppPallete.textColorDarkMode : AppPallete.textColorLightMode;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: textColor,
          ),
          onPressed: () => context.go('/dashboard'),
        ),
        actions: [
          IconButton(
            icon: Icon(
              themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
              color: AppPallete.primaryColor,
            ),
            onPressed: () {
              themeProvider.toggleTheme();
            },
          ),
        ],
      ),
      body: BlocBuilder<WorkoutCubit, WorkoutState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.error != null) {
            return Center(child: Text(state.error!));
          }

          if (state.workouts.isEmpty) {
            return Center(
              child: Text(
                'No workouts yet',
                style: TextStyle(
                  fontSize: 18,
                  color: textColor,
                ),
              ),
            );
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Center(
                  child: Text(
                    'Your Workouts',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  itemCount: state.workouts.length,
                  itemBuilder: (context, index) {
                    final workout = state.workouts[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: WorkoutCard(
                        workout: workout,
                        onTap: () => _showWorkoutDetails(context, workout),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showWorkoutDetails(BuildContext context, Workout workout) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final isDark = themeProvider.isDarkMode;
    final textColor = isDark ? AppPallete.textColorDarkMode : AppPallete.textColorLightMode;
    final backgroundColor = isDark ? AppPallete.darkBgColor : AppPallete.lightBgColor;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: backgroundColor,
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
                color: AppPallete.lightPrimaryColor,
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
                padding: const EdgeInsets.all(16.0),
                itemCount: workout.exercises.length,
                itemBuilder: (context, index) {
                  final exercise = workout.exercises[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      side: const BorderSide(color: AppPallete.lightPrimaryColor),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            exercise.exerciseName,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                          const SizedBox(height: 12),
                          if (exercise.sets != null)
                            Text(
                              'Sets: ${exercise.sets}',
                              style: TextStyle(color: textColor),
                            ),
                          if (exercise.reps != null)
                            Text(
                              'Reps: ${exercise.reps}',
                              style: TextStyle(color: textColor),
                            ),
                          if (exercise.duration != null)
                            Text(
                              'Duration: ${exercise.duration} seconds',
                              style: TextStyle(color: textColor),
                            ),
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

} 