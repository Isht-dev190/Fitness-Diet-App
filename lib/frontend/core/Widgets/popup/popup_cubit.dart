import 'package:flutter_bloc/flutter_bloc.dart';

enum PopupState { initial, visible, hidden }

class PopupCubit extends Cubit<PopupState> {
  PopupCubit() : super(PopupState.initial);

  void showPopup() {
    emit(PopupState.visible);
    Future.delayed(const Duration(seconds: 2), () {
      hidePopup();
    });
  }

  void hidePopup() {
    emit(PopupState.hidden);
  }
} 