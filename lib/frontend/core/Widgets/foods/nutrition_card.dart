import 'package:flutter/material.dart';
import 'package:app_dev_fitness_diet/frontend/core/Models/food_model.dart';
import 'package:app_dev_fitness_diet/frontend/core/theme/app_pallete.dart';
import 'package:provider/provider.dart';
import 'package:app_dev_fitness_diet/frontend/core/theme/theme_provider.dart';
import 'package:app_dev_fitness_diet/frontend/core/Widgets/foods/nutrition_item.dart';

class NutritionCard extends StatelessWidget {
  final Food food;

  const NutritionCard({
    super.key,
    required this.food,
  });

  @override
  Widget build(BuildContext context) {
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
            NutritionItem(label: 'Portion Size', value: '${food.portionSize}g', textColor: textColor),
            const Divider(color: AppPallete.primaryColor),
            NutritionItem(label: 'Calories', value: '${food.calories} kcal', textColor: textColor),
            const Divider(color: AppPallete.primaryColor),
            NutritionItem(label: 'Protein', value: '${food.protein}g', textColor: textColor),
            const Divider(color: AppPallete.primaryColor),
            NutritionItem(label: 'Carbs', value: '${food.carbs}g', textColor: textColor),
            const Divider(color: AppPallete.primaryColor),
            NutritionItem(label: 'Fats', value: '${food.fats}g', textColor: textColor),
          ],
        ),
      ),
    );
  }
} 