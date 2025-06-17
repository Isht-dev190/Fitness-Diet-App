import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_dev_fitness_diet/frontend/core/theme/app_pallete.dart';
import 'package:app_dev_fitness_diet/frontend/features/workouts/workout_cubit.dart';
import 'package:app_dev_fitness_diet/frontend/core/Widgets/workouts/add_workout_page.dart';
import 'package:app_dev_fitness_diet/frontend/core/Widgets/workouts/workout_list_page.dart';

class WorkoutCarouselScreen extends StatelessWidget {
  const WorkoutCarouselScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Theme.of(context);
    final isDark = themeProvider.brightness == Brightness.dark;
    final textColor = isDark ? AppPallete.textColorDarkMode : AppPallete.textColorLightMode;

    // Load workouts when screen is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WorkoutCubit>().loadWorkouts();
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Workouts'),
        backgroundColor: themeProvider.scaffoldBackgroundColor,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocListener<WorkoutCubit, WorkoutState>(
        listener: (context, state) {
          if (state is WorkoutError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: BlocBuilder<WorkoutCubit, WorkoutState>(
          builder: (context, state) {
            return switch (state) {
              WorkoutInitial() => const Center(child: CircularProgressIndicator()),
              WorkoutLoading() => const Center(child: CircularProgressIndicator()),
              WorkoutError(message: final message) => Center(child: Text('Error: $message')),
              WorkoutLoaded(workouts: final workouts) => Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppPallete.primaryColor),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: PageView(
                      children: [
                        AddWorkoutPage(textColor: textColor),
                        WorkoutListPage(workouts: workouts),
                      ],
                    ),
                  ),
                ),
            };
          },
        ),
      ),
    );
  }
} 