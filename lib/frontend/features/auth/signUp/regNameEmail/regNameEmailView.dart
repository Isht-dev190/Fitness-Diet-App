import 'package:app_dev_fitness_diet/frontend/core/utils/button_cubit.dart';
import 'package:app_dev_fitness_diet/frontend/core/utils/custom_button.dart';
import 'package:app_dev_fitness_diet/frontend/features/auth/signUp/bloc/cubit/register_cubit.dart';
import 'package:app_dev_fitness_diet/frontend/features/auth/signUp/regNameEmail/regNameEmailViewModel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:app_dev_fitness_diet/frontend/core/utils/textBox.dart';
import 'package:app_dev_fitness_diet/frontend/core/theme/app_pallete.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegEmail extends StatelessWidget {
  RegEmail({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final backgroundColor = isDark ? AppPallete.darkBgColor : AppPallete.lightBgColor;
    final textColor = isDark ? AppPallete.textColorDarkMode : AppPallete.textColorLightMode;

    return BlocProvider(
      create: (_) => ButtonCubit(),
      child: Builder(
        builder: (context) {
          final buttonCubit = context.read<ButtonCubit>();
          final registerCubit = context.read<RegisterCubit>();
          final viewModel = RegEmailViewModel.create(buttonCubit, registerCubit);

          _emailController.addListener(() {
            viewModel.onEmailChanged(_emailController.text);
          });
          _passwordController.addListener(() {
            viewModel.onPasswordChanged(_passwordController.text);
          });
          return Scaffold(
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
            body: Column(
              children: [
                const SizedBox(height: 70),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 35.0,
                      ),
                      child: Text(
                        'EMAIL',
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: Textbox(
                    hintText: 'Enter your email',
                    isObscureText: false,
                    onChanged: (value) {
                      viewModel.onEmailChanged(value);
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 35.0,
                      ),
                      child: Text(
                        'PASSWORD',
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: Textbox(
                    hintText: 'Enter your password',
                    isObscureText: true,
                    onChanged: (value) {
                      viewModel.onPasswordChanged(value);
                    },
                  ),
                ),
                const SizedBox(height: 30),
                BlocBuilder<ButtonCubit, ButtonState>(
                  builder: (context, state) {
                    return CustomButton(
                      text: 'SIGN UP',
                      onPressed: () => viewModel.onNextPressed(context),
                      state: state,
                    );
                  },
                ),
                const SizedBox(height: 20),
                const Text('OR'),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () => viewModel.signUpWithGoogle(context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/icons/google.png',
                          height: 24,
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Sign up with Google',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
