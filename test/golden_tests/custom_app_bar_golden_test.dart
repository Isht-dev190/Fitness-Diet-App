import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:app_dev_fitness_diet/frontend/core/theme/theme_provider.dart';
import 'package:app_dev_fitness_diet/frontend/core/Widgets/app%20bar/custom_app_bar.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await SharedPreferences.getInstance();
  });

  testWidgets('Golden test for CustomAppBar', (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(400, 60));

    // Test light mode
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ],
        child: MaterialApp(
          home: Scaffold(
            appBar: CustomAppBar(isRootRoute: true),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await expectLater(
      find.byType(AppBar),
      matchesGoldenFile('goldens/custom_app_bar_light.png'),
    );

    // Test dark mode
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => ThemeProvider()..toggleTheme(),
          ),
        ],
        child: MaterialApp(
          home: Scaffold(
            appBar: CustomAppBar(isRootRoute: true),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await expectLater(
      find.byType(AppBar),
      matchesGoldenFile('goldens/custom_app_bar_dark.png'),
    );
  });
} 