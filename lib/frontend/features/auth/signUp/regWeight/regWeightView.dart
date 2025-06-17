import 'package:app_dev_fitness_diet/frontend/core/Widgets/cupertino%20Picker/custom_picker.dart';
import 'package:app_dev_fitness_diet/frontend/core/Widgets/cupertino%20Picker/picker_cubit.dart';
import 'package:app_dev_fitness_diet/frontend/core/theme/app_pallete.dart';
import 'package:app_dev_fitness_diet/frontend/core/utils/button_cubit.dart';
import 'package:app_dev_fitness_diet/frontend/core/utils/custom_button.dart';
import 'package:app_dev_fitness_diet/frontend/features/auth/signUp/bloc/cubit/register_cubit.dart';
import 'package:app_dev_fitness_diet/frontend/features/auth/signUp/regWeight/regWeightViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class RegWeightView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final backgroundColor = isDark ? AppPallete.darkBgColor : AppPallete.lightBgColor;
    final textColor = isDark ? AppPallete.textColorDarkMode : AppPallete.textColorLightMode;

    final List<int> kgList = List.generate(181, (i) => 20 + i);
    final List<int> lbList = List.generate(397, (i) => 44 + i);
    final buttonCubit = context.read<ButtonCubit>();
    final registerCubit = context.read<RegisterCubit>();
    
    final pickerCubit = PickerCubit(
      list1: kgList,
      list2: lbList,
      option1: 'kg',
      option2: 'lb',
    );
    
    final viewModel = RegWeightViewModel(
      pickerCubit: pickerCubit,
      buttonCubit: buttonCubit, 
      registerCubit: registerCubit
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
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: textColor),
            onPressed: () => context.pop(),
          ),
        ),
        body: BlocProvider.value(
          value: pickerCubit,
          child: Column(
            children: [
              Lottie.asset(
                'assets/animations/register_weight.json',
                height: 150,
                repeat: false,
                animate: true,
              ),
              const SizedBox(height: 10),
              Text(
                'WEIGHT',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: AppPallete.primaryColor,
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: CustomPicker(
                  list1: kgList,
                  list2: lbList,
                  option1: 'kg',
                  option2: 'lb',
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 50, 0.0, 0.0),
                child: BlocBuilder<ButtonCubit, ButtonState>(
                  builder: (context, state) {
                    return CustomButton(
                      text: 'NEXT',
                      onPressed: () => viewModel.onNextPressed(context),
                      state: ButtonState.enabled,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}