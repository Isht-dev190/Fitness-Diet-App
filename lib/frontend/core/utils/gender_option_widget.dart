
import 'package:flutter/material.dart';

class GenderOptionWidget extends StatelessWidget {
  final String imagePath;
  final bool isSelected;
  final Color selectedColor;
  final VoidCallback onTap;

  const GenderOptionWidget({
    Key? key,
    required this.imagePath,
    required this.isSelected,
    required this.selectedColor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? selectedColor : Colors.transparent,
            width: 8,
          ),
        ),
        child: CircleAvatar(
          radius: 60,
          backgroundColor: Colors.transparent,
          backgroundImage: AssetImage(imagePath),
        ),
      ),
    );
  }
}
