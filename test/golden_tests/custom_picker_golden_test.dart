import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_dev_fitness_diet/frontend/core/Widgets/cupertino%20Picker/custom_picker.dart';

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  testWidgets('CustomPicker Golden Test', (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(400, 300));

    // Test with hours and minutes
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomPicker(
            list1: List.generate(24, (index) => index),
            list2: List.generate(60, (index) => index),
            option1: 'hours',
            option2: 'minutes',
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    await expectLater(
      find.byType(CustomPicker),
      matchesGoldenFile('../golden_tests/goldens/custom_picker_time.png'),
    );

    // Test with sets and reps
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomPicker(
            list1: List.generate(10, (index) => index + 1),
            list2: List.generate(30, (index) => index + 1),
            option1: 'sets',
            option2: 'reps',
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    await expectLater(
      find.byType(CustomPicker),
      matchesGoldenFile('../golden_tests/goldens/custom_picker_exercise.png'),
    );
  });
} 