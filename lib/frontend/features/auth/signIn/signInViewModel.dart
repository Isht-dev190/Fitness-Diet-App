import 'package:app_dev_fitness_diet/frontend/core/utils/button_cubit.dart';
import 'package:app_dev_fitness_diet/frontend/core/utils/validate_functions.dart';
import 'package:app_dev_fitness_diet/frontend/features/auth/signIn/signInRepo.dart';
import 'package:app_dev_fitness_diet/frontend/features/auth/AuthService.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:app_dev_fitness_diet/frontend/core/utils/error_dialogBox.dart';

class SignInViewModel {
  String _email = '';
  String _password = '';
  final ButtonCubit buttonCubit;
  late final SignInRepository _signInRepository;
  late final ErrorDialogbox _errorDialogBox;

  // Regular constructor
  SignInViewModel({required this.buttonCubit, SignInRepository? signInRepository, ErrorDialogbox? errorDialogbox}) {
    _signInRepository = signInRepository ?? SignInRepository(AuthService());
    _errorDialogBox = errorDialogbox ?? ErrorDialogbox();
  }
  
  // Factory constructor that creates everything needed
  factory SignInViewModel.create(ButtonCubit buttonCubit) {
    final authService = AuthService();
    final signInRepository = SignInRepository(authService);
    return SignInViewModel(
      buttonCubit: buttonCubit,
      signInRepository: signInRepository,
      errorDialogbox: ErrorDialogbox(),
    );
  }

  void onEmailChanged(String email) {
    _email = email;
    _validateInputs();
  }
   
  void onPasswordChanged(String password) {
    _password = password;
    _validateInputs();
  }
   
  void _validateInputs() {
    final isEmailValid = ValidateFunctions.isValidEmail(_email);
    final isPasswordValid = ValidateFunctions.isValidPassword(_password);
     
    buttonCubit.updateButtonState(isEmailValid && isPasswordValid);
  }

  // Non-async method that initiates the sign-in process
  void onNextPressed(BuildContext context) {
    // Disable button during sign-in
    buttonCubit.updateButtonState(false);
    
    // Start the sign-in process without awaiting here
    _performSignIn(context);
  }
  
  // Private method to handle the async work
  Future<void> _performSignIn(BuildContext context) async {
    try {
      final result = await _signInRepository.signInUser(_email, _password);
      
      result.fold(
        (failure) {
          // Re-enable button
          buttonCubit.updateButtonState(true);
          
          // Show error dialog
          if (context.mounted) {
            _errorDialogBox.showErrorDialog(context, failure.message);
          }
        }, 
        (success) {
          // Navigate on success
          if (context.mounted) {
            context.push('/dashboard');
          }
        }
      );
    } catch (e) {
      // Re-enable button
      buttonCubit.updateButtonState(true);
      
      if (context.mounted) {
        _errorDialogBox.showErrorDialog(context, 'An unexpected error occurred');
      }
    }
  }

  // Method to handle Google sign-in
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final result = await _signInRepository.signInWithGoogle();
      
      result.fold(
        (failure) {
          if (context.mounted) {
            _errorDialogBox.showErrorDialog(context, failure.message);
          }
        }, 
        (success) {
          if (context.mounted) {
            context.push('/dashboard');
          }
        }
      );
    } catch (e) {
      if (context.mounted) {
        _errorDialogBox.showErrorDialog(context, 'An unexpected error occurred during Google sign-in');
      }
    }
  }
}
