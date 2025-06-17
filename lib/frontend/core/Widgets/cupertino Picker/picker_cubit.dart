import 'package:app_dev_fitness_diet/frontend/core/Widgets/cupertino%20Picker/picker_cubit_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PickerCubit extends Cubit<PickerState>{
  final List<int> list1;
  final List<int> list2;
  final String option1;
  final String option2;

  PickerCubit({
    required this.list1,
    required this.list2,
    required this.option1,
    required this.option2,
  }) : super(
    PickerState(
      currentlist: list1,
      selectedOption: option1,
      selectedValue: getMiddleIndex(list1),
    ),
  );
// Add this to your PickerCubit class
int getCurrentValue() {
  return state.selectedValue;
}

String getCurrentUnit() {
  return state.selectedOption;
}

static int getMiddleIndex(List<int> list1) {
    return list1[list1.length ~/ 2];
}

  void selectedOption(String option) {
    if(option == option1) {
      emit(state.copyWith(
        currentList: list1,
        selectedOption: option1,
        selectedValue: getMiddleIndex(list1)
      ));
    } else if(option == option2) {
      emit(state.copyWith(
        currentList: list2,
        selectedOption: option2,
        selectedValue: getMiddleIndex(list2)
      ));
    }
  }


  void setValue(int value) {
    emit(state.copyWith(selectedValue: value));
  }






}

