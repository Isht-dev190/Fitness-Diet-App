import 'package:bloc/bloc.dart';

enum ButtonState {
  disabled,
  enabled
}

class ButtonCubit extends Cubit<ButtonState>{
  ButtonCubit(): super(ButtonState.disabled);

  void updateButtonState(bool isValid) {
    emit(isValid ? ButtonState.enabled : ButtonState.disabled);
  }

}