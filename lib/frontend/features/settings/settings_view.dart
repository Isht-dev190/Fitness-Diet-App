import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'settings_viewmodel.dart';
import '../../core/Models/user_model.dart';
import '../../core/theme/app_pallete.dart';

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

    if (viewModel.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

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

    if (user == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

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
            _buildProfileHeader(context, user),
            const SizedBox(height: 24),
            _buildInfoSection(context, user),
            const SizedBox(height: 24),
            _buildActionButtons(context, viewModel),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, UserModel user) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = isDark ? AppPallete.textColorDarkMode : AppPallete.textColorLightMode;

    return Center(
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppPallete.primaryColor.withOpacity(0.1),
              border: Border.all(
                color: AppPallete.primaryColor,
                width: 2,
              ),
            ),
            child: Center(
              child: Text(
                user.email.isNotEmpty ? user.email[0].toUpperCase() : '?',
                style: const TextStyle(
                  color: AppPallete.primaryColor,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            user.email,
            style: TextStyle(
              color: textColor,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(BuildContext context, UserModel user) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final backgroundColor = isDark ? AppPallete.darkBgColor : AppPallete.lightBgColor;
    final textColor = isDark ? AppPallete.textColorDarkMode : AppPallete.textColorLightMode;

    return Card(
      elevation: 2,
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: AppPallete.primaryColor.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Profile Information',
              style: TextStyle(
                color: textColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildInfoRow(context, 'Height', '${user.height} cm'),
            _buildInfoRow(context, 'Weight', '${user.weight} kg'),
            _buildInfoRow(context, 'BMI', user.bmi.toStringAsFixed(1)),
            _buildInfoRow(context, 'TDEE', '${user.tdee.toStringAsFixed(0)} kcal'),
            _buildInfoRow(context, 'Age', user.age.toString()),
            _buildInfoRow(context, 'Gender', user.gender),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = isDark ? AppPallete.textColorDarkMode : AppPallete.textColorLightMode;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: textColor.withOpacity(0.7),
              fontSize: 16,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: textColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, SettingsViewModel viewModel) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ElevatedButton.icon(
        onPressed: viewModel.isLoading ? null : () => viewModel.signOut(context),
        icon: const Icon(Icons.logout),
        label: Text(viewModel.isLoading ? 'Signing Out...' : 'Sign Out'),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppPallete.primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
} 