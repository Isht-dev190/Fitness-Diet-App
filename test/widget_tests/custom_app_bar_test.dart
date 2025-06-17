import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_dev_fitness_diet/frontend/core/Widgets/app%20bar/custom_app_bar.dart';
import '../helpers/test_helpers.dart';

void main() {
  setUp(() async {
    await TestHelpers.setupSharedPreferences();
  });

  testWidgets('CustomAppBar shows menu icon in root route', (WidgetTester tester) async {
    await tester.pumpWidget(
      TestHelpers.wrapWithProviders(
        const CustomAppBar(isRootRoute: true),
      ),
    );

    expect(find.byIcon(Icons.menu), findsOneWidget);
    expect(find.byIcon(Icons.arrow_back), findsNothing);
  });

  testWidgets('CustomAppBar shows back icon in non-root route', (WidgetTester tester) async {
    await tester.pumpWidget(
      TestHelpers.wrapWithProviders(
        const CustomAppBar(isRootRoute: false),
      ),
    );

    expect(find.byIcon(Icons.arrow_back), findsOneWidget);
    expect(find.byIcon(Icons.menu), findsNothing);
  });

  testWidgets('CustomAppBar shows theme toggle button', (WidgetTester tester) async {
    await tester.pumpWidget(
      TestHelpers.wrapWithProviders(
        const CustomAppBar(isRootRoute: true),
      ),
    );

    expect(find.byIcon(Icons.dark_mode), findsOneWidget);
  });
} 