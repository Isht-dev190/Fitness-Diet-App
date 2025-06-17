import 'package:app_dev_fitness_diet/frontend/core/utils/button_cubit.dart';
import 'package:app_dev_fitness_diet/frontend/features/auth/signUp/bloc/cubit/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegGenderViewModel {
String gender = '';
final RegisterCubit registerCubit;
final ButtonCubit buttonCubit;
RegGenderViewModel({required this.registerCubit, required this.buttonCubit}) {
  buttonCubit.updateButtonState(false);
}

  void updateGender(String gender) {
    registerCubit.updateGender(gender);
    buttonCubit.updateButtonState(true);
  }


  void onNextPressed(BuildContext context) {
    //registerCubit.updateGender(gender);
    if( context.mounted ) {
      context.push('/register-height');
    }
    
  }
}