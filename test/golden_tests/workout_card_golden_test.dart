import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:app_dev_fitness_diet/frontend/core/theme/theme_provider.dart';
import 'package:app_dev_fitness_diet/frontend/core/Widgets/workout_card.dart';
import 'package:app_dev_fitness_diet/frontend/core/Models/workout_model.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await SharedPreferences.getInstance();
  });

  testWidgets('Golden test for WorkoutCard', (WidgetTester tester) async {
    final testWorkout = Workout(
      id: '1',
      name: 'Morning Workout',
      exercises: [
        WorkoutExercise(
          exerciseName: 'Push-ups',
          sets: 3,
          reps: 10,
          duration: 0,
        ),
        WorkoutExercise(
          exerciseName: 'Squats',
          sets: 4,
          reps: 15,
          duration: 0,
        ),
      ],
      scheduledDates: [
        DateTime(2024, 1, 1), // Monday
        DateTime(2024, 1, 3), // Wednesday
        DateTime(2024, 1, 5), // Friday
      ],
      hour: 7,
      minute: 30,
      userEmail: 'test@example.com',
      notificationsEnabled: true,
    );

    await tester.binding.setSurfaceSize(const Size(400, 200));

    // Test light mode
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: WorkoutCard(
                  workout: testWorkout,
                  onTap: () {},
                ),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await expectLater(
      find.byType(WorkoutCard),
      matchesGoldenFile('goldens/workout_card_light.png'),
    );

    // Test dark mode
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => ThemeProvider()..toggleTheme(),
          ),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: WorkoutCard(
                  workout: testWorkout,
                  onTap: () {},
                ),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await expectLater(
      find.byType(WorkoutCard),
      matchesGoldenFile('goldens/workout_card_dark.png'),
    );
  });
} 