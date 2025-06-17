import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_dev_fitness_diet/frontend/core/Widgets/Icons/home_icon.dart';
import 'package:app_dev_fitness_diet/frontend/core/Widgets/Icons/exercise_icon.dart';
import 'package:app_dev_fitness_diet/frontend/core/Widgets/Icons/ai_icon.dart';

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  testWidgets('Icon Widgets Golden Test', (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(300, 100));

    // Test Home icon
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(
            child: Home(),
          ),
        ),
      ),
    );

    await expectLater(
      find.byType(Home),
      matchesGoldenFile('../golden_tests/goldens/home_icon.png'),
    );

    // Test Exercise icon
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(
            child: ExerciseList(),
          ),
        ),
      ),
    );

    await expectLater(
      find.byType(ExerciseList),
      matchesGoldenFile('../golden_tests/goldens/exercise_icon.png'),
    );

    // Test AI icon
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(
            child: AiIcon(),
          ),
        ),
      ),
    );

    await expectLater(
      find.byType(AiIcon),
      matchesGoldenFile('../golden_tests/goldens/ai_icon.png'),
    );
  });
} 