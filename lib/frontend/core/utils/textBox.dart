import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_dev_fitness_diet/frontend/core/theme/app_pallete.dart';

class Textbox extends StatelessWidget {
  final String hintText;
  final bool isObscureText;
  final Function(String)? onChanged;

  const Textbox({
    super.key,
    required this.hintText,
    this.isObscureText = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = isDark ? AppPallete.textColorDarkMode : AppPallete.textColorLightMode;
    final hintColor = isDark ? AppPallete.inputHintDarkMode : AppPallete.inputHintLightMode;

    return TextField(
      obscureText: isObscureText,
      onChanged: onChanged,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.transparent,
        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(
          fontSize: 16,
          color: hintColor,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppPallete.primaryColor, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppPallete.primaryColor, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppPallete.primaryColor, width: 2),
        ),
      ),
      keyboardType: TextInputType.text,
      style: GoogleFonts.poppins(
        fontSize: 16,
        color: textColor,
      ),
    );
  }
}