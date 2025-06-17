import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_dev_fitness_diet/frontend/features/workouts/workout_cubit.dart';
import 'package:app_dev_fitness_diet/frontend/core/Widgets/workouts/workout_list_page.dart';
import 'package:go_router/go_router.dart';
import 'package:app_dev_fitness_diet/frontend/core/theme/app_pallete.dart';

class WorkoutListScreen extends StatelessWidget {
  const WorkoutListScreen({super.key});

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
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor),
          onPressed: () => context.go('/dashboard'),
        ),
        title: const Text('Workouts'),
        backgroundColor: themeProvider.scaffoldBackgroundColor,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocBuilder<WorkoutCubit, WorkoutState>(
        builder: (context, state) {
          return switch (state) {
            WorkoutInitial() => const Center(child: CircularProgressIndicator()),
            WorkoutLoading() => const Center(child: CircularProgressIndicator()),
            WorkoutError(message: final message) => Center(child: Text('Error: $message')),
            WorkoutLoaded(workouts: final workouts) => WorkoutListPage(workouts: workouts),
          };
        },
      ),
    );
  }
} 