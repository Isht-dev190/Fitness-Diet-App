import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_dev_fitness_diet/frontend/core/Models/exercise_model.dart';

void main() {
  testWidgets('Exercise View Golden Test', (WidgetTester tester) async {
    final exercises = [
      Exercise(
        name: 'Push-ups',
        category: 'strength',
        description: 'Basic push-up exercise',
        iconSvg: 'assets/helper svgs/strength.svg',
        videoUrl: 'https://example.com/video',
      ),
      Exercise(
        name: 'Squats',
        category: 'lower body',
        description: 'Basic squat exercise',
        iconSvg: 'assets/helper svgs/lowerbody.svg',
        videoUrl: 'https://example.com/video',
      ),
    ];

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData.light(),
        home: Scaffold(
          body: ListView.builder(
            itemCount: exercises.length,
            itemBuilder: (context, index) {
              final exercise = exercises[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: const Icon(Icons.fitness_center),
                  title: Text(exercise.name),
                  subtitle: Text(exercise.category),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
              );
            },
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    await expectLater(
      find.byType(Scaffold),
      matchesGoldenFile('goldens/exercise_view.png'),
    );
  });
} 