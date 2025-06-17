import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_dev_fitness_diet/frontend/core/Widgets/bottom%20Navigation%20bar/nav_bar_item.dart';
import '../helpers/test_helpers.dart';

void main() {
  setUp(() async {
    await TestHelpers.setupSharedPreferences();
  });

  testWidgets('NavBarItem displays icon and label', (WidgetTester tester) async {
    await tester.pumpWidget(
      TestHelpers.wrapWithProviders(
        NavBarItem(
          icon: Icons.home,
          label: 'Home',
          isSelected: false,
          onTap: () {},
        ),
      ),
    );

    expect(find.byIcon(Icons.home), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);
  });

  testWidgets('NavBarItem responds to tap', (WidgetTester tester) async {
    bool wasTapped = false;

    await tester.pumpWidget(
      TestHelpers.wrapWithProviders(
        NavBarItem(
          icon: Icons.home,
          label: 'Home',
          isSelected: false,
          onTap: () => wasTapped = true,
        ),
      ),
    );

    await tester.tap(find.byType(NavBarItem));
    await tester.pump();
    expect(wasTapped, true);
  });

  testWidgets('NavBarItem shows different style when selected', (WidgetTester tester) async {
    await tester.pumpWidget(
      TestHelpers.wrapWithProviders(
        NavBarItem(
          icon: Icons.home,
          label: 'Home',
          isSelected: true,
          onTap: () {},
        ),
      ),
    );

    final iconFinder = find.byIcon(Icons.home);
    final Icon icon = tester.widget<Icon>(iconFinder);
    expect(icon.color, isNotNull);
  });
} 