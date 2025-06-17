import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:app_dev_fitness_diet/frontend/core/theme/theme_provider.dart';
import 'package:app_dev_fitness_diet/frontend/features/foods/foods_view.dart';
import 'package:app_dev_fitness_diet/frontend/features/foods/food_viewModel.dart';
import 'package:app_dev_fitness_diet/frontend/features/foods/food_repo.dart';
import 'package:app_dev_fitness_diet/frontend/core/Models/food_model.dart';
import 'package:app_dev_fitness_diet/frontend/core/error/failures.dart';
import 'package:dartz/dartz.dart';

class TestFoodRepository implements FoodRepository {
  @override
  Future<Either<Failure, List<Food>>> getFoods() async {
    return Right([
      Food(
        name: 'Chicken Salad',
        portionSize: 200,
        calories: 350,
        protein: 25,
        carbs: 10,
        fats: 15,
        imageUrl: 'assets/helper svgs/protein.svg',
        category: 'protein',
        description: 'Fresh chicken salad',
      ),
      Food(
        name: 'Greek Yogurt',
        portionSize: 150,
        calories: 120,
        protein: 15,
        carbs: 8,
        fats: 5,
        imageUrl: 'assets/helper svgs/dairy.svg',
        category: 'dairy',
        description: 'Plain Greek yogurt',
      ),
    ]);
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late TestFoodRepository testRepo;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await SharedPreferences.getInstance();
    testRepo = TestFoodRepository();
  });

  testWidgets('Golden test for FoodsView', (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(400, 600));

    final foodViewModel = FoodViewModel(testRepo);
    final themeProvider = ThemeProvider();

    // Test light mode
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<ThemeProvider>.value(value: themeProvider),
          ChangeNotifierProvider<FoodViewModel>.value(value: foodViewModel),
        ],
        child: MaterialApp(
          theme: ThemeData.light(),
          home: const Scaffold(
            body: FoodsView(),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await expectLater(
      find.byType(FoodsView),
      matchesGoldenFile('goldens/food_view_light.png'),
    );

    // Test dark mode
    themeProvider.toggleTheme();
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<ThemeProvider>.value(value: themeProvider),
          ChangeNotifierProvider<FoodViewModel>.value(value: foodViewModel),
        ],
        child: MaterialApp(
          theme: ThemeData.dark(),
          home: const Scaffold(
            body: FoodsView(),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await expectLater(
      find.byType(FoodsView),
      matchesGoldenFile('goldens/food_view_dark.png'),
    );
  });
} 