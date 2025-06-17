import 'package:app_dev_fitness_diet/frontend/core/Widgets/cupertino%20Picker/picker_cubit.dart';
import 'package:app_dev_fitness_diet/frontend/core/utils/button_cubit.dart';
import 'package:app_dev_fitness_diet/frontend/features/auth/signUp/bloc/cubit/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegHeightViewModel {
   final PickerCubit pickerCubit;
   final RegisterCubit registerCubit;
   final ButtonCubit buttonCubit;
  RegHeightViewModel({required this.pickerCubit, required this.registerCubit, required this.buttonCubit});

  void onNextPressed(BuildContext context) {
     final currentHeight = pickerCubit.getCurrentValue();
    //final heightUnit = pickerCubit.getCurrentUnit();
    buttonCubit.updateButtonState(true);
    registerCubit.updateHeight(currentHeight);
    if(context.mounted) {
      context.push('/register-weight');
    }
  }
}