import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_dev_fitness_diet/frontend/core/Models/food_model.dart';

void main() {
  testWidgets('Food View Golden Test', (WidgetTester tester) async {

    final foods = [
      Food(
        name: 'Apple',
        portionSize: 100,
        calories: 52,
        protein: 0.3,
        carbs: 14,
        fats: 0.2,
        imageUrl: 'assets/helper svgs/fruits.svg',
        category: 'fruits',
        description: 'Fresh apple',
      ),
      Food(
        name: 'Chicken Breast',
        portionSize: 100,
        calories: 165,
        protein: 31,
        carbs: 0,
        fats: 3.6,
        imageUrl: 'assets/helper svgs/protein.svg',
        category: 'protein',
        description: 'Grilled chicken breast',
      ),
    ];

    // Build our widget
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData.light(),
        home: Scaffold(
          body: ListView.builder(
            itemCount: foods.length,
            itemBuilder: (context, index) {
              final food = foods[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: const Icon(Icons.food_bank),
                  title: Text(food.name),
                  subtitle: Text(food.category),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
              );
            },
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    await expectLater(
      find.byType(Scaffold),
      matchesGoldenFile('goldens/food_view.png'),
    );
  });
} 