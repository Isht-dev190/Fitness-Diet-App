import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_dev_fitness_diet/frontend/core/Widgets/workout_card.dart';
import 'package:app_dev_fitness_diet/frontend/core/Models/workout_model.dart';

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  testWidgets('WorkoutCard Golden Test', (WidgetTester tester) async {
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

    // Build our widget in a 400x200 surface
    await tester.binding.setSurfaceSize(const Size(400, 200));

    // Test light mode
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData.light(),
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
    );

    await expectLater(
      find.byType(WorkoutCard),
      matchesGoldenFile('goldens/workout_card_light.png'),
    );

    // Test dark mode
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData.dark(),
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
    );

    await expectLater(
      find.byType(WorkoutCard),
      matchesGoldenFile('goldens/workout_card_dark.png'),
    );
  });
} 