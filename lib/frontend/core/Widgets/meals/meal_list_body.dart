import 'package:flutter/material.dart';
import 'package:app_dev_fitness_diet/frontend/core/Widgets/meals/meal_card.dart';
import 'package:app_dev_fitness_diet/frontend/core/Widgets/meals/meal_details_modal.dart';
import 'package:app_dev_fitness_diet/frontend/features/meals/meal_state.dart';

class MealListBody extends StatelessWidget {
  final MealState state;
  final Color textColor;

  const MealListBody({
    super.key,
    required this.state,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.error != null) {
      return Center(child: Text(state.error!));
    }

    if (state.meals.isEmpty) {
      return Center(
        child: Text(
          'No meals yet',
          style: TextStyle(
            fontSize: 18,
            color: textColor,
          ),
        ),
      );
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Center(
            child: Text(
              'Your Meals',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: state.meals.length,
            itemBuilder: (context, index) {
              final meal = state.meals[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: GestureDetector(
                  onTap: () {
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
                  child: MealCard(meal: meal),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
} 