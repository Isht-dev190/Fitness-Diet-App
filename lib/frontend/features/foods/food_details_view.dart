import 'package:flutter/material.dart';
import 'package:app_dev_fitness_diet/frontend/core/Models/food_model.dart';
import 'package:app_dev_fitness_diet/frontend/core/theme/app_pallete.dart';
import 'package:provider/provider.dart';
import 'package:app_dev_fitness_diet/frontend/core/theme/theme_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FoodDetailsView extends StatelessWidget {
  final Food food;

  const FoodDetailsView({
    super.key,
    required this.food,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;
    final backgroundColor = isDark ? AppPallete.darkBgColor : AppPallete.lightBgColor;
    final textColor = isDark ? AppPallete.textColorDarkMode : AppPallete.textColorLightMode;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Food Image
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SvgPicture.asset(
                    food.imageUrl,
                    height: 150,
                    width: 150,
                    fit: BoxFit.contain,
                    placeholderBuilder: (context) => Container(
                      height: 150,
                      width: 150,
                      color: Colors.grey[300],
                      child: const Icon(Icons.fastfood, size: 75),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Food Name
                  Text(
                    food.name,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Description
                  Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    food.description,
                    style: TextStyle(
                      fontSize: 16,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Category
                  Text(
                    'Category',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    food.category,
                    style: TextStyle(
                      fontSize: 16,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Nutrition Facts
                  Text(
                    'Nutrition Facts',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppPallete.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildNutritionCard(context, food),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNutritionCard(BuildContext context, Food food) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;
    final backgroundColor = isDark ? AppPallete.darkBgColor : AppPallete.lightBgColor;
    final textColor = isDark ? AppPallete.textColorDarkMode : AppPallete.textColorLightMode;

    return Card(
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: const BorderSide(color: AppPallete.primaryColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildNutritionItem('Portion Size', '${food.portionSize}g', textColor),
            const Divider(color: AppPallete.primaryColor),
            _buildNutritionItem('Calories', '${food.calories} kcal', textColor),
            const Divider(color: AppPallete.primaryColor),
            _buildNutritionItem('Protein', '${food.protein}g', textColor),
            const Divider(color: AppPallete.primaryColor),
            _buildNutritionItem('Carbs', '${food.carbs}g', textColor),
            const Divider(color: AppPallete.primaryColor),
            _buildNutritionItem('Fats', '${food.fats}g', textColor),
          ],
        ),
      ),
    );
  }

  Widget _buildNutritionItem(String label, String value, Color textColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: textColor,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppPallete.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
} 