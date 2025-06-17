import 'package:app_dev_fitness_diet/frontend/features/meals/portion_size_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PortionSizeDialog extends StatelessWidget {
  const PortionSizeDialog({Key? key}) : super(key: key);

  // Builds the dialog for entering portion size
  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();
    final portionSizeCubit = context.read<PortionSizeCubit>();

    return AlertDialog(
      title: const Text('Enter Portion Size'),
      content: BlocBuilder<PortionSizeCubit, double?>(
        builder: (context, portionSize) {
          return TextField(
            controller: textController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Portion Size (g)',
              hintText: 'Enter portion size in grams',
            ),
            onChanged: portionSizeCubit.updatePortionSize,
          );
        },
      ),
      actions: [
        TextButton(
          onPressed: () {
            portionSizeCubit.reset();
            context.pop();
          },
          child: const Text('Cancel'),
        ),
        BlocBuilder<PortionSizeCubit, double?>(
          builder: (context, portionSize) {
            return TextButton(
              onPressed: portionSize != null
                ? () => context.pop(portionSize)
                : null,
              child: const Text('OK'),
            );
          },
        ),
      ],
    );
  }
} 