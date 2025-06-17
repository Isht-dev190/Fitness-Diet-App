import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:app_dev_fitness_diet/frontend/core/theme/theme_provider.dart';
import 'package:app_dev_fitness_diet/frontend/core/Widgets/dashboard%20drawer/custom_drawer.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await SharedPreferences.getInstance();
  });

  testWidgets('Golden test for CustomDrawer', (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(300, 600));

    // Test light mode
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ],
        child: const MaterialApp(
          home: Scaffold(
            drawer: CustomDrawer(),
            body: SizedBox(),
          ),
        ),
      ),
    );

    await tester.dragFrom(
      tester.getTopLeft(find.byType(Scaffold)),
      const Offset(300, 0),
    );
    await tester.pumpAndSettle();

    await expectLater(
      find.byType(CustomDrawer),
      matchesGoldenFile('goldens/custom_drawer_light.png'),
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
            drawer: CustomDrawer(),
            body: SizedBox(),
          ),
        ),
      ),
    );

    await tester.dragFrom(
      tester.getTopLeft(find.byType(Scaffold)),
      const Offset(300, 0),
    );
    await tester.pumpAndSettle();

    await expectLater(
      find.byType(CustomDrawer),
      matchesGoldenFile('goldens/custom_drawer_dark.png'),
    );
  });
} 