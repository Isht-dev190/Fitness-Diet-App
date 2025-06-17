import 'package:app_dev_fitness_diet/frontend/core/utils/button_cubit.dart';
import 'package:app_dev_fitness_diet/frontend/core/utils/validate_functions.dart';
import 'package:app_dev_fitness_diet/frontend/features/auth/signUp/bloc/cubit/register_cubit.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class RegAgeViewModel {
String _age = '';
final ButtonCubit buttonCubit;
final RegisterCubit registerCubit;
  RegAgeViewModel({required this.buttonCubit, required this.registerCubit,});

  void onAgeChanged(String newAge) {
    _age = newAge;
    _validateInputs(); 
  }
  bool isAgeValid(String age) {
    return ValidateFunctions.isValidAge(_age);
  }
  void _validateInputs() {
    final isAgeValid = ValidateFunctions.isValidAge(_age);
    buttonCubit.updateButtonState(isAgeValid);
  }

  void onNextPressed(BuildContext context, String age) {
    registerCubit.updateAge(age);
    if(context.mounted) {
      context.push('/register-gender');
    }
    
  }


}