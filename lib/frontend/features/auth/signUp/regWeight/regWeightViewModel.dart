import 'package:app_dev_fitness_diet/frontend/core/Widgets/cupertino%20Picker/picker_cubit.dart';
import 'package:app_dev_fitness_diet/frontend/core/utils/button_cubit.dart';
import 'package:app_dev_fitness_diet/frontend/features/auth/signUp/bloc/cubit/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegWeightViewModel {
   final PickerCubit pickerCubit;
   final RegisterCubit registerCubit;
   final ButtonCubit buttonCubit;
  RegWeightViewModel({required this.pickerCubit, required this.registerCubit, required this.buttonCubit});

  void onNextPressed(BuildContext context) {
     final currentWeight = pickerCubit.getCurrentValue();
    //final weightUnit = pickerCubit.getCurrentUnit();
    buttonCubit.updateButtonState(true);
    registerCubit.updateWeight(currentWeight);
    if(context.mounted) {
      context.push('/register-name');
    }
  }
}