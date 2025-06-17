import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_dev_fitness_diet/frontend/core/Widgets/meals/meal_details.dart';
import 'package:app_dev_fitness_diet/frontend/core/Models/meal_model.dart';
import 'package:app_dev_fitness_diet/frontend/core/Models/food_model.dart';

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  testWidgets('MealDetails Golden Test', (WidgetTester tester) async {
    final testFood1 = Food(
      name: 'Grilled Chicken',
      portionSize: 100,
      calories: 165,
      protein: 31,
      carbs: 0,
      fats: 3.6,
      category: 'Protein',
      description: 'Lean grilled chicken breast',
      imageUrl: 'chicken.jpg',
    );

    final testFood2 = Food(
      name: 'Brown Rice',
      portionSize: 100,
      calories: 111,
      protein: 2.6,
      carbs: 23,
      fats: 0.9,
      category: 'Carbs',
      description: 'Whole grain brown rice',
      imageUrl: 'rice.jpg',
    );

    final testMeal = Meal(
      id: '1',
      name: 'Healthy Lunch',
      foods: [
        MealFood.fromFood(
          food: testFood1,
          portionSize: 150,
        ),
        MealFood.fromFood(
          food: testFood2,
          portionSize: 100,
        ),
      ],
      userEmail: 'test@example.com',
    );

    await tester.binding.setSurfaceSize(const Size(400, 600));

    // Test light mode
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData.light(),
        home: Scaffold(
          body: MealDetails(meal: testMeal),
        ),
      ),
    );

    await expectLater(
      find.byType(MealDetails),
      matchesGoldenFile('../golden_tests/goldens/meal_details_light.png'),
    );

    // Test dark mode
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData.dark(),
        home: Scaffold(
          body: MealDetails(meal: testMeal),
        ),
      ),
    );

    await expectLater(
      find.byType(MealDetails),
      matchesGoldenFile('../golden_tests/goldens/meal_details_dark.png'),
    );
  });
} 