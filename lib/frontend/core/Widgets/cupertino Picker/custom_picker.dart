import 'package:app_dev_fitness_diet/frontend/core/Widgets/cupertino%20Picker/picker_cubit.dart';
import 'package:app_dev_fitness_diet/frontend/core/Widgets/cupertino%20Picker/picker_cubit_state.dart';
import 'package:app_dev_fitness_diet/frontend/core/theme/app_pallete.dart';
import 'package:app_dev_fitness_diet/frontend/core/utils/toggle_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomPicker extends StatelessWidget {
  final List<int> list1;
  final List<int> list2;
  final String option1;
  final String option2;

  const CustomPicker({super.key, required this.list1, required this.list2, required this.option1, required this.option2});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PickerCubit(list1: list1, list2: list2, option1: option1, option2: option2),
      child: BlocBuilder<PickerCubit, PickerState>(
        builder: (context, state) {
          final controller = FixedExtentScrollController(
            initialItem: state.currentlist.indexOf(state.selectedValue),
          );
          return LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        constraints: BoxConstraints(
                          maxHeight: constraints.maxHeight * 0.7,
                          minHeight: 200,
                        ),
                        decoration: BoxDecoration(
                          color: AppPallete.lightPrimaryColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: SizedBox(
                                height: 150,
                                child: CupertinoPicker(
                                  itemExtent: 40,
                                  backgroundColor: Colors.transparent,
                                  scrollController: controller,
                                  onSelectedItemChanged: (index) {
                                    context.read<PickerCubit>().setValue(state.currentlist[index]);
                                  },
                                  children: state.currentlist
                                      .map((val) => Center(
                                            child: Text(
                                              "$val ${state.selectedOption.toUpperCase()}",
                                              style: const TextStyle(fontSize: 18, color: AppPallete.lightBgColor),
                                            ),
                                          ))
                                      .toList(),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  CustomToggleButton(
                                    label: context.read<PickerCubit>().option1,
                                    isSelected: state.selectedOption == context.read<PickerCubit>().option1,
                                    onTap: () => context.read<PickerCubit>().selectedOption(context.read<PickerCubit>().option1),
                                  ),
                                  CustomToggleButton(
                                    label: context.read<PickerCubit>().option2,
                                    isSelected: state.selectedOption == context.read<PickerCubit>().option2,
                                    onTap: () => context.read<PickerCubit>().selectedOption(context.read<PickerCubit>().option2),
                                  ),
                                ],
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
          );
        },
      ),
    );
  }
}