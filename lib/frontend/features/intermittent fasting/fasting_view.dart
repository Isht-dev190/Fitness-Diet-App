import 'package:app_dev_fitness_diet/frontend/core/theme/app_pallete.dart';
import 'package:app_dev_fitness_diet/frontend/core/Models/fasting_option.dart';
import 'package:app_dev_fitness_diet/frontend/features/intermittent%20fasting/fasting_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_dev_fitness_diet/frontend/core/theme/theme_provider.dart';
import 'package:go_router/go_router.dart';

class FastingView extends StatelessWidget {
  const FastingView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FastingViewModel(),
      child: const FastingContent(),
    );
  }
}

class FastingContent extends StatelessWidget {
  const FastingContent({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;
    final backgroundColor = isDark ? AppPallete.darkBgColor : AppPallete.lightBgColor;
    final textColor = isDark ? Colors.white : AppPallete.textColorLightMode;
    final viewModel = context.watch<FastingViewModel>();

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        color: backgroundColor,
        child: Column(
          children: [
            // Fasting Type Selector
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: AppPallete.darkBgColor,
                    ),
                    onPressed: () => context.go('/dashboard'),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppPallete.primaryColor,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButton<FastingOption>(
                      value: viewModel.selectedOption,
                      dropdownColor: backgroundColor,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: AppPallete.primaryColor,
                      ),
                      underline: Container(),
                      items: FastingOption.options.map((option) {
                        return DropdownMenuItem(
                          value: option,
                          child: Text(option.name),
                        );
                      }).toList(),
                      onChanged: (option) {
                        if (option != null) viewModel.selectOption(option);
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Timer Display
            Expanded(
              flex: 2,
              child: Center(
                child: Container(
                  width: 400,
                  height: 400,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppPallete.primaryColor,
                      width: 10,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      viewModel.formattedRemainingTime,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Control Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 45,
                      child: ElevatedButton(
                        onPressed: viewModel.isRunning ? null : viewModel.startFasting,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: viewModel.isRunning ? AppPallete.primaryColor.withOpacity(0.5) : AppPallete.primaryColor,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(
                              color: viewModel.isRunning ? AppPallete.primaryColor.withOpacity(0.3) : AppPallete.primaryColor,
                              width: 2,
                            ),
                          ),
                        ),
                        child: Text(
                          'START',
                          style: TextStyle(
                            color: isDark ? AppPallete.textColorDarkMode : AppPallete.textColorLightMode,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      height: 45,
                      child: ElevatedButton(
                        onPressed: viewModel.isRunning ? viewModel.endFasting : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: !viewModel.isRunning ? AppPallete.primaryColor.withOpacity(0.5) : AppPallete.primaryColor,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(
                              color: !viewModel.isRunning ? AppPallete.primaryColor.withOpacity(0.3) : AppPallete.primaryColor,
                              width: 2,
                            ),
                          ),
                        ),
                        child: Text(
                          'END',
                          style: TextStyle(
                            color: isDark ? AppPallete.textColorDarkMode : AppPallete.textColorLightMode,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Fasting Logs
            Expanded(
              flex: 3,
              child: Container(
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppPallete.primaryColor,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: viewModel.logs.length,
                  itemBuilder: (context, index) {
                    final log = viewModel.logs[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppPallete.primaryColor.withOpacity(0.3),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                log.formattedDate,
                                style: TextStyle(
                                  color: textColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                log.fastingType,
                                style: const TextStyle(
                                  color: AppPallete.primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${log.formattedStartTime} - ${log.formattedEndTime}',
                                style: TextStyle(color: textColor),
                              ),
                              Text(
                                log.formattedDuration,
                                style: TextStyle(
                                  color: textColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 