import 'package:app_dev_fitness_diet/frontend/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class CustomToggleButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const CustomToggleButton({ super.key, required this.label, required this.isSelected, required this.onTap});


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: 80,
        decoration: BoxDecoration(
          color: isSelected ? AppPallete.primaryColor : AppPallete.lightPrimaryColor,
          border: Border.all(
            color: isSelected ? AppPallete.textColorDarkMode : AppPallete.lightPrimaryColor, // Border color
            width: 2.0,         // Border width
          ),
          borderRadius: BorderRadius.circular(15),

        ),
        child:Center( 
        child: Text(
          label.toUpperCase(),
          style: TextStyle(
            color: isSelected ? AppPallete.lightBgColor : AppPallete.lightBgColor,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),

        )


      ),
    );
  }
}