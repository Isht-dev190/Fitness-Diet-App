import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_dev_fitness_diet/frontend/features/workouts/workout_cubit.dart';
import 'package:app_dev_fitness_diet/frontend/core/Widgets/workouts/workout_list_page.dart';

class WorkoutListScreen extends StatelessWidget {
  const WorkoutListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Workouts'),
        backgroundColor: themeProvider.scaffoldBackgroundColor,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocBuilder<WorkoutCubit, WorkoutState>(
        builder: (context, state) {
          return switch (state) {
            WorkoutInitial() => const Center(child: Text('No workouts available')),
            WorkoutLoading() => const Center(child: CircularProgressIndicator()),
            WorkoutError(message: final message) => Center(child: Text('Error: $message')),
            WorkoutLoaded(workouts: final workouts) => WorkoutListPage(workouts: workouts),
          };
        },
      ),
    );
  }
} 