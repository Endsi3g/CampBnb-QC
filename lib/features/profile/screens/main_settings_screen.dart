import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';

class MainSettingsScreen extends StatelessWidget {
  const MainSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? AppColors.textDark : AppColors.textPrimary,
          ),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Paramètres',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isDark ? AppColors.textDark : AppColors.textPrimary,
            fontFamily: 'PlusJakartaSans',
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(
        children: [
          _buildSettingsItem(
            context,
            icon: Icons.notifications,
            title: 'Notifications',
            onTap: () => context.push('/settings/notifications'),
            isDark: isDark,
          ),
          _buildSettingsItem(
            context,
            icon: Icons.lock,
            title: 'Sécurité et compte',
            onTap: () => context.push('/settings/security'),
            isDark: isDark,
          ),
          _buildSettingsItem(
            context,
            icon: Icons.help_outline,
            title: 'Aide et soutien',
            onTap: () => context.push('/help'),
            isDark: isDark,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: AppColors.primary,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          color: isDark ? AppColors.textDark : AppColors.textPrimary,
          fontFamily: 'PlusJakartaSans',
        ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: isDark ? AppColors.textDark : AppColors.textPrimary,
      ),
      onTap: onTap,
    );
  }
}

