import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'settings_viewmodel.dart';
import '../../core/Models/user_model.dart';
import '../../core/theme/app_pallete.dart';
import '../../core/Widgets/settings/profile_section.dart';
import '../../core/Widgets/settings/action_buttons.dart';

// Main settings screen widget
class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SettingsViewModel(),
      child: const _SettingsViewContent(),
    );
  }
}

// Content of settings screen with all the UI elements
class _SettingsViewContent extends StatelessWidget {
  const _SettingsViewContent();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SettingsViewModel>();
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final backgroundColor = isDark ? AppPallete.darkBgColor : AppPallete.lightBgColor;
    final textColor = isDark ? AppPallete.textColorDarkMode : AppPallete.textColorLightMode;
    final UserModel? user = viewModel.userData;

    // Show loading spinner while data is being fetched
    if (viewModel.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // Show error message if something goes wrong
    if (viewModel.error != null) {
      return Scaffold(
        backgroundColor: backgroundColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Error: ${viewModel.error}',
                style: TextStyle(color: textColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => context.read<SettingsViewModel>().signOut(context),
                child: const Text('Try Again'),
              ),
            ],
          ),
        ),
      );
    }

    // Show default view if no user data
    if (user == null) {
      return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: backgroundColor,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          title: Text(
            'Settings',
            style: TextStyle(
              color: textColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileSection(user: UserModel(
                email: 'Unknown',
                password: '',
                age: '',
                gender: '',
                height: 0,
                weight: 0,
                lifestyle: '',
                bmi: 0,
                tdee: 0,
              )),
              const SizedBox(height: 24),
              ActionButtons(viewModel: viewModel),
            ],
          ),
        ),
      );
    }

    // Main settings view with user data
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'Settings',
          style: TextStyle(
            color: textColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileSection(user: user),
            const SizedBox(height: 24),
            ActionButtons(viewModel: viewModel),
          ],
        ),
      ),
    );
  }
} 