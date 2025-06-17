import 'package:flutter/material.dart';
import 'package:app_dev_fitness_diet/frontend/core/Models/user_model.dart';
import 'package:app_dev_fitness_diet/frontend/core/theme/app_pallete.dart';

class ProfileSection extends StatelessWidget {
  final UserModel user;

  const ProfileSection({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = isDark ? AppPallete.textColorDarkMode : AppPallete.textColorLightMode;
    final backgroundColor = isDark ? AppPallete.darkBgColor : AppPallete.lightBgColor;

    return Column(
      children: [
        // User avatar and email
        Center(
          child: Column(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppPallete.primaryColor.withOpacity(0.1),
                  border: Border.all(
                    color: AppPallete.primaryColor,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Text(
                    user.email.isNotEmpty ? user.email[0].toUpperCase() : '?',
                    style: const TextStyle(
                      color: AppPallete.primaryColor,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                user.email,
                style: TextStyle(
                  color: textColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        // User stats card
        Card(
          elevation: 2,
          color: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: AppPallete.primaryColor.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Profile Information',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                // User stats rows
                InfoRow(label: 'Height', value: '${user.height} cm', textColor: textColor),
                InfoRow(label: 'Weight', value: '${user.weight} kg', textColor: textColor),
                InfoRow(label: 'Age', value: user.age, textColor: textColor),
                InfoRow(label: 'Gender', value: user.gender, textColor: textColor),
                InfoRow(label: 'Lifestyle', value: user.lifestyle, textColor: textColor),
                InfoRow(label: 'BMI', value: user.bmi.toStringAsFixed(1), textColor: textColor),
                InfoRow(label: 'TDEE', value: '${user.tdee.toStringAsFixed(0)} kcal', textColor: textColor),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final Color textColor;

  const InfoRow({
    super.key,
    required this.label,
    required this.value,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: textColor.withOpacity(0.7),
              fontSize: 16,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: textColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
} 