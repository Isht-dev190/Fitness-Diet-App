// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_dev_fitness_diet/frontend/core/theme/theme_provider.dart';
import 'package:app_dev_fitness_diet/frontend/features/workouts/workout_cubit.dart';
import 'package:app_dev_fitness_diet/frontend/features/workouts/workout_repository.dart';
import 'package:app_dev_fitness_diet/frontend/features/workouts/workout_service.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:app_dev_fitness_diet/frontend/core/Models/workout_model.dart';
import 'package:app_dev_fitness_diet/authRouter.dart';

void main() {
  setUp(() async {
    await Hive.initFlutter();
    Hive.registerAdapter(WorkoutAdapter());
    await Hive.openBox<Workout>('workouts');
  });

  tearDown(() async {
    // Clean up after each test
    await Hive.deleteBoxFromDisk('workouts');
  });

  testWidgets('App smoke test', (WidgetTester tester) async {
    final workoutBox = Hive.box<Workout>('workouts');
    final workoutServiceCubit = WorkoutServiceCubit(workoutBox);
    final workoutRepository = WorkoutRepository(workoutServiceCubit);
    final workoutCubit = WorkoutCubit(workoutRepository);

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
          BlocProvider<WorkoutServiceCubit>.value(
            value: workoutServiceCubit,
          ),
          BlocProvider<WorkoutCubit>.value(
            value: workoutCubit,
          ),
        ],
        child: MaterialApp.router(
          title: 'Fitness & Diet App',
          routerConfig: router,
        ),
      ),
    );

    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
