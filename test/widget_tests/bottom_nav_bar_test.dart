import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_dev_fitness_diet/frontend/core/Widgets/bottom%20Navigation%20bar/bottom_nav_bar.dart';
import '../helpers/test_helpers.dart';

void main() {
  setUp(() async {
    await TestHelpers.setupSharedPreferences();
  });

  testWidgets('BottomNavBar shows all navigation items', (WidgetTester tester) async {
    await tester.pumpWidget(
      TestHelpers.wrapWithProviders(
        const BottomNavBar(currentRoute: '/dashboard'),
      ),
    );

    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Exercises'), findsOneWidget);
    expect(find.text('Foods'), findsOneWidget);
    expect(find.text('Tips'), findsOneWidget);
  });

  testWidgets('BottomNavBar highlights current route', (WidgetTester tester) async {
    await tester.pumpWidget(
      TestHelpers.wrapWithProviders(
        const BottomNavBar(currentRoute: '/dashboard/exercises'),
      ),
    );

    expect(find.text('Exercises'), findsOneWidget);
    final exerciseItem = find.ancestor(
      of: find.text('Exercises'),
      matching: find.byType(GestureDetector),
    );
    expect(exerciseItem, findsOneWidget);
  });

  testWidgets('BottomNavBar shows all icons', (WidgetTester tester) async {
    await tester.pumpWidget(
      TestHelpers.wrapWithProviders(
        const BottomNavBar(currentRoute: '/dashboard'),
      ),
    );

    expect(find.byIcon(Icons.home), findsOneWidget);
    expect(find.byIcon(Icons.fitness_center), findsOneWidget);
    expect(find.byIcon(Icons.fastfood), findsOneWidget);
    expect(find.byIcon(Icons.lightbulb_outline_rounded), findsOneWidget);
  });
} 