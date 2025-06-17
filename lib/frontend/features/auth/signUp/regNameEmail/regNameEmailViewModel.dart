import 'package:app_dev_fitness_diet/frontend/core/Models/user_model.dart';
import 'package:app_dev_fitness_diet/frontend/core/utils/button_cubit.dart';
import 'package:app_dev_fitness_diet/frontend/core/utils/validate_functions.dart';
import 'package:app_dev_fitness_diet/frontend/features/auth/AuthService.dart';
import 'package:app_dev_fitness_diet/frontend/features/auth/signUp/bloc/cubit/register_cubit.dart';
import 'package:app_dev_fitness_diet/frontend/features/auth/signUp/regNameEmail/RegUserRepo.dart';
import 'package:app_dev_fitness_diet/frontend/core/storage/user_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:app_dev_fitness_diet/frontend/core/utils/error_dialogBox.dart';

class RegEmailViewModel {
  String _email = '';
  String _password = '';
  final ButtonCubit buttonCubit;
  final RegisterCubit registerCubit;
  late final RegUserRepository _regUserRepository;
  late final ErrorDialogbox _errorDialogBox;
  late final AuthService _authService;
  final _userStorage = UserStorageService();

  // Regular constructor
  RegEmailViewModel({
    required this.buttonCubit, 
    RegUserRepository? regUserRepository, 
    ErrorDialogbox? errorDialogbox, 
    required this.registerCubit,
    AuthService? authService,
  }) {
    _regUserRepository = regUserRepository ?? RegUserRepository(AuthService());
    _errorDialogBox = errorDialogbox ?? ErrorDialogbox();
    _authService = authService ?? AuthService();
  }
  
  factory RegEmailViewModel.create(ButtonCubit buttonCubit, RegisterCubit registerCubit) {
    final authService = AuthService();
    final regUserRepo = RegUserRepository(authService);
    return RegEmailViewModel(
      buttonCubit: buttonCubit,
      registerCubit: registerCubit, 
      errorDialogbox: ErrorDialogbox(),
      regUserRepository: regUserRepo,
      authService: authService,
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
    registerCubit.updateEmail(_email);
    registerCubit.updatePassword(_password);
    // Start the sign-in process without awaiting here
    final user = registerCubit.user;

    _performRegistration(context, user);
  }
  
  // Private method to handle the async work
  Future<void> _performRegistration(BuildContext context, UserModel user) async {
    try {
      final result = await _regUserRepository.RegisterUser(user);
      
      result.fold(
        (failure) {
          // Re-enable button
          buttonCubit.updateButtonState(true);
          
          // Show error dialog
          if (context.mounted) {
            _errorDialogBox.showErrorDialog(context, failure.message);
          }
        }, 
        (success) async {
          // Store user data in Hive
          await _userStorage.saveUser(user);
          
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

  // Method to handle Google sign-up
  Future<void> signUpWithGoogle(BuildContext context) async {
    try {
      final result = await _authService.signUpWithGoogle();
      
      if (result) {
        if (context.mounted) {
          context.push('/dashboard');
        }
      } else {
        if (context.mounted && _authService.error != null) {
          _errorDialogBox.showErrorDialog(context, _authService.error!);
        }
      }
    } catch (e) {
      if (context.mounted) {
        _errorDialogBox.showErrorDialog(context, 'An unexpected error occurred during Google sign-up');
      }
    }
  }
}
