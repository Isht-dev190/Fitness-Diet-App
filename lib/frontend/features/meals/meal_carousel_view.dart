import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_dev_fitness_diet/frontend/core/theme/app_pallete.dart';
import 'package:app_dev_fitness_diet/frontend/features/meals/meal_cubit.dart';
import 'package:provider/provider.dart';
import 'package:app_dev_fitness_diet/frontend/core/theme/theme_provider.dart';
import 'package:app_dev_fitness_diet/frontend/features/meals/meal_state.dart';
import 'package:app_dev_fitness_diet/frontend/core/Widgets/meals/add_meal_page.dart';
import 'package:app_dev_fitness_diet/frontend/core/Widgets/meals/meal_list_page.dart';
import 'package:app_dev_fitness_diet/frontend/core/Widgets/meals/meal_details_modal.dart';

class MealCarouselScreen extends StatelessWidget {
  const MealCarouselScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;
    final textColor = isDark ? AppPallete.textColorDarkMode : AppPallete.textColorLightMode;

    return BlocBuilder<MealCubit, MealState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.error != null) {
          return Center(child: Text('Error: ${state.error}'));
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppPallete.primaryColor, width: 2.0),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: PageView(
              children: [
                AddMealPage(textColor: textColor),
                MealListPage(
                  meals: state.meals,
                  onMealTap: (context, meal) {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      builder: (context) => DraggableScrollableSheet(
                        initialChildSize: 0.9,
                        maxChildSize: 0.9,
                        minChildSize: 0.5,
                        expand: false,
                        builder: (context, scrollController) => MealDetailsModal(meal: meal, scrollController: scrollController),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
} 