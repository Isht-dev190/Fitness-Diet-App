import 'package:app_dev_fitness_diet/frontend/core/utils/button_cubit.dart';
import 'package:app_dev_fitness_diet/frontend/core/utils/custom_button.dart';
import 'package:app_dev_fitness_diet/frontend/core/utils/gender_option_widget.dart';
import 'package:app_dev_fitness_diet/frontend/features/auth/signUp/bloc/cubit/register_cubit.dart';
import 'package:app_dev_fitness_diet/frontend/features/auth/signUp/bloc/cubit/register_cubit_state.dart';
import 'package:app_dev_fitness_diet/frontend/features/auth/signUp/regGender/regGenderViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:app_dev_fitness_diet/frontend/core/theme/app_pallete.dart';


class RegGenderView extends StatelessWidget {
  const RegGenderView({super.key});


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final backgroundColor = isDark ? AppPallete.darkBgColor : AppPallete.lightBgColor;
    final textColor = isDark ? AppPallete.textColorDarkMode : AppPallete.textColorLightMode;

  final registerCubit = context.read<RegisterCubit>();
  final buttonCubit = context.read<ButtonCubit>();
  final viewModel = RegGenderViewModel(registerCubit: registerCubit, buttonCubit: buttonCubit);

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
            return Column(
              children: [
                    // **Lottie Animation**
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0,0.0,0.0,20.0),
                      child: Lottie.asset(
                        'assets/animations/register_gender.json',
                        height: 150,
                        repeat: true,
                        reverse: true,
                        animate: true,
                      ),
                    ),
                     const Text(
                  'GENDER',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppPallete.primaryColor),
                ),
                const SizedBox(height: 32),
                  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0,0.0,45.0,0.0),
                      child: GenderOptionWidget(
                        imagePath: 'assets/pngs/register_male_white.png',
                        isSelected: state.gender == 'male',
                        selectedColor: AppPallete.greenhighlight,
                        onTap: () {
                          viewModel.updateGender('male');
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(45.0,0.0,0.0,0.0),
                      child: GenderOptionWidget(
                        imagePath: 'assets/pngs/register_female_white.png',
                        isSelected: state.gender == 'female',
                        selectedColor: AppPallete.pinkhighlight,
                        
                        onTap: () {
                          viewModel.updateGender('female');
                      
                        },
                        
                      ),
                    ),
                  ],
                ),
                   Padding(
                     padding: const EdgeInsets.fromLTRB(5.0, 90.0, 8.0, 5.0),
                     child: BlocBuilder<ButtonCubit, ButtonState>(
                         builder: (context, state) {
                         return CustomButton(text: 'NEXT', onPressed: () => viewModel.onNextPressed(context), state: state);
                      }
                      ),
                   ),
              



              ]
            );
          }
      )
    ),
    );
  }
}