class PickerState {
  final List<int> currentlist;
  final String selectedOption;
  final int selectedValue;
  PickerState({required this.currentlist, required this.selectedOption, required this.selectedValue});

  PickerState copyWith({
    List<int>? currentList,
    String? selectedOption,
    int? selectedValue,
  }) {
    return PickerState(currentlist: currentList ?? this.currentlist, selectedOption: selectedOption ?? this.selectedOption, selectedValue: selectedValue ?? this.selectedValue);

  }

  


}

