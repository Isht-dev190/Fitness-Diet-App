import 'package:app_dev_fitness_diet/frontend/core/theme/app_pallete.dart';
import 'package:app_dev_fitness_diet/frontend/core/utils/button_cubit.dart';
import 'package:app_dev_fitness_diet/frontend/core/utils/custom_button.dart';
import 'package:app_dev_fitness_diet/frontend/features/auth/signUp/bloc/cubit/register_cubit_state.dart';
import 'package:app_dev_fitness_diet/frontend/features/auth/signUp/regAge/regAgeViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:app_dev_fitness_diet/frontend/features/auth/signUp/bloc/cubit/register_cubit.dart';
import 'package:app_dev_fitness_diet/frontend/core/utils/textBox.dart';

class RegAgeView extends StatelessWidget{
  RegAgeView({super.key});
  final TextEditingController _controller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final backgroundColor = isDark ? AppPallete.darkBgColor : AppPallete.lightBgColor;
    final textColor = isDark ? AppPallete.textColorDarkMode : AppPallete.textColorLightMode;

  final buttonCubit = context.read<ButtonCubit>();
  final registerCubit = context.read<RegisterCubit>();
  final viewModel = RegAgeViewModel(
    buttonCubit: buttonCubit,
    registerCubit: registerCubit,
  );
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (didPop) return;
        context.pop();
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: backgroundColor,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: textColor),
            onPressed: () => context.pop(),
          ),
        ),

        body: BlocBuilder<RegisterCubit, RegisterCubitState>(

          builder: (context, state) {
            final age = state.age;
            if (_controller.text != state.age) {
              _controller.text = state.age;
              
            }

            //void isAgeValid = RegAgeViewModel.onAgeChanged(state.age);

            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Lottie Animation
                    Transform.translate(
                    offset: const Offset(0, -100), 
                    child: Lottie.asset(
                      'assets/animations/register_age.json',
                      height: 180,
                      repeat: true,
                      reverse: true,
                      animate: true,
                    ),
                  ),

                  
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0,0.0,0.0,10.0),
                      child: Text(
                        "AGE",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppPallete.primaryColor,
                        ),
                      ),
                    ),


                    // TextField
                    Textbox(
                      hintText: 'Enter your age',
                      isObscureText: false,
                      onChanged: (value) {
                          viewModel.onAgeChanged(value);                        
                      },
                    ),

                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Text(
                          "Please enter a valid age between 5 and 120.",
                          style: TextStyle(color: AppPallete.primaryColor, fontSize: 14),
                        ),
                      ),

                    
                   // Next Button
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0,20.0,0.0, 8.0),
                      child: BlocBuilder<ButtonCubit, ButtonState>(
                         builder: (context, state) {
                         return CustomButton(text: 'NEXT', onPressed: () => viewModel.onNextPressed(context, age), state: state);
                      }
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
}
}