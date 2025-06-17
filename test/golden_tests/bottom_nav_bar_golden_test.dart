import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:app_dev_fitness_diet/frontend/core/theme/theme_provider.dart';
import 'package:app_dev_fitness_diet/frontend/core/Widgets/bottom%20Navigation%20bar/bottom_nav_bar.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await SharedPreferences.getInstance();
  });

  testWidgets('Golden test for BottomNavBar', (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(400, 80));

    // Test light mode
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ],
        child: const MaterialApp(
          home: Scaffold(
            bottomNavigationBar: BottomNavBar(currentRoute: '/dashboard'),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await expectLater(
      find.byType(BottomNavBar),
      matchesGoldenFile('goldens/bottom_nav_bar_light.png'),
    );

    // Test dark mode
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => ThemeProvider()..toggleTheme(),
          ),
        ],
        child: const MaterialApp(
          home: Scaffold(
            bottomNavigationBar: BottomNavBar(currentRoute: '/dashboard'),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await expectLater(
      find.byType(BottomNavBar),
      matchesGoldenFile('goldens/bottom_nav_bar_dark.png'),
    );
  });
} 