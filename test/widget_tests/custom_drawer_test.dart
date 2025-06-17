import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_dev_fitness_diet/frontend/core/Widgets/dashboard%20drawer/custom_drawer.dart';
import '../helpers/test_helpers.dart';

void main() {
  setUp(() async {
    await TestHelpers.setupSharedPreferences();
  });

  testWidgets('CustomDrawer shows all menu items', (WidgetTester tester) async {
    await tester.pumpWidget(
      TestHelpers.wrapWithProviders(
        const CustomDrawer(),
      ),
    );

    expect(find.text('Menu'), findsOneWidget);
    expect(find.text('Workouts'), findsOneWidget);
    expect(find.text('Meals'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);
  });

  testWidgets('CustomDrawer shows all icons', (WidgetTester tester) async {
    await tester.pumpWidget(
      TestHelpers.wrapWithProviders(
        const CustomDrawer(),
      ),
    );

    expect(find.byIcon(Icons.fitness_center), findsOneWidget);
    expect(find.byIcon(Icons.restaurant_menu), findsOneWidget);
    expect(find.byIcon(Icons.settings), findsOneWidget);
  });

  testWidgets('CustomDrawer menu items are tappable', (WidgetTester tester) async {
    await tester.pumpWidget(
      TestHelpers.wrapWithProviders(
        const CustomDrawer(),
      ),
    );

    expect(find.byType(ListTile), findsNWidgets(3));
    final workoutsTile = find.ancestor(
      of: find.text('Workouts'),
      matching: find.byType(ListTile),
    );
    expect(workoutsTile, findsOneWidget);
  });
} 