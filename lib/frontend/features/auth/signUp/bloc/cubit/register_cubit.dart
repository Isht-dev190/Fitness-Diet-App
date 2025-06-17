import 'package:app_dev_fitness_diet/frontend/core/Models/user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:app_dev_fitness_diet/frontend/features/auth/signUp/bloc/cubit/register_cubit_state.dart';

class RegisterCubit extends Cubit<RegisterCubitState> {
  RegisterCubit() : super(RegisterCubitState());

  void updateAge(String age) => emit(state.copyWith(age: age));
  void updateLifestyle(String lifestyle) => emit(state.copyWith(lifestyle: lifestyle));
  void updateGender(String gender) => emit(state.copyWith(gender: gender));
  void updateHeight(int height) => emit(state.copyWith(height: height));
  void updateWeight(int weight) => emit(state.copyWith(weight: weight));
  void updateEmail(String email) => emit(state.copyWith(email: email));
  void updatePassword(String password) => emit(state.copyWith(password: password));

  /// Getter for BMI
  int get bmi {
    if (state.height > 0) {
      return (state.weight / ((state.height / 100) * (state.height / 100))).round();
    }
    return 0;
  }

  /// Getter for TDEE
  int get tdee {
    return (bmi * 24 * 1.2).round(); // You can customize the multiplier based on lifestyle
  }

  /// Build UserModel from current state
  UserModel get user => UserModel(
    email: state.email,
    password: state.password,
    gender: state.gender,
    age: state.age,
    height: state.height,
    weight: state.weight,
    lifestyle: state.lifestyle,
    bmi: bmi,
    tdee: bmi,
  );
}
