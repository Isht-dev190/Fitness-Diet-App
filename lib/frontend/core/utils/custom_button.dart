import 'package:app_dev_fitness_diet/frontend/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_dev_fitness_diet/frontend/core/utils/button_cubit.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final ButtonState state;
  final VoidCallback? onPressed;
  const CustomButton({
    super.key,
     required this.text,
     required this.onPressed,
     required this.state     
  });

  @override
  Widget build(BuildContext context) {
 

    return  ElevatedButton(
                      onPressed: state == ButtonState.enabled  ? onPressed: null,
                       // Disable button if age is invalid
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(250, 60),
                        backgroundColor: state == ButtonState.enabled ? AppPallete.primaryColor : AppPallete.textColorDarkMode,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                          color: state == ButtonState.disabled ? Colors.grey : Colors.transparent, // border for disabled
                          width: 2,
                        ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 10,
                      
                      ),
                      child: Text(
                        text,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
  }
}