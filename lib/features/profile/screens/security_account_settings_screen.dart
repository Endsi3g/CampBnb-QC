import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';

class SecurityAccountSettingsScreen extends StatelessWidget {
  const SecurityAccountSettingsScreen({super.key});

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
            color: isDark ? AppColors.textDark : AppColors.charcoalGrey,
          ),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Sécurité et compte',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isDark ? AppColors.textDark : AppColors.charcoalGrey,
            fontFamily: 'PlusJakartaSans',
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Connexion et sécurité
            _buildSectionTitle('Connexion et sécurité'),
            const SizedBox(height: 8),
            _buildSettingsCard(
              context,
              [
                _buildSettingsItem(
                  icon: Icons.lock,
                  title: 'Changer le mot de passe',
                  onTap: () {},
                  isDark: isDark,
                ),
                Divider(height: 1, color: Colors.grey.shade300),
                _buildSettingsItem(
                  icon: Icons.shield_lock,
                  title: 'Authentification à deux facteurs',
                  onTap: () {},
                  isDark: isDark,
                ),
                Divider(height: 1, color: Colors.grey.shade300),
                _buildSettingsItem(
                  icon: Icons.devices,
                  title: 'Appareils connectés',
                  onTap: () {},
                  isDark: isDark,
                ),
              ],
              isDark,
            ),
            const SizedBox(height: 24),
            // Informations du compte
            _buildSectionTitle('Informations du compte'),
            const SizedBox(height: 8),
            _buildSettingsCard(
              context,
              [
                _buildSettingsItem(
                  icon: Icons.person,
                  title: 'Modifier les informations personnelles',
                  onTap: () {},
                  isDark: isDark,
                ),
                Divider(height: 1, color: Colors.grey.shade300),
                _buildSettingsItem(
                  icon: Icons.mail,
                  title: 'Gérer l\'adresse courriel',
                  onTap: () {},
                  isDark: isDark,
                ),
                Divider(height: 1, color: Colors.grey.shade300),
                _buildSettingsItem(
                  icon: Icons.call,
                  title: 'Gérer le numéro de téléphone',
                  onTap: () {},
                  isDark: isDark,
                ),
              ],
              isDark,
            ),
            const SizedBox(height: 24),
            // Actions sur le compte
            _buildSectionTitle('Actions sur le compte'),
            const SizedBox(height: 8),
            _buildSettingsCard(
              context,
              [
                _buildSettingsItem(
                  icon: Icons.delete,
                  title: 'Désactiver le compte',
                  onTap: () {},
                  isDark: isDark,
                  isDestructive: true,
                ),
              ],
              isDark,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
          letterSpacing: 1.2,
          fontFamily: 'PlusJakartaSans',
        ),
      ),
    );
  }

  Widget _buildSettingsCard(
    BuildContext context,
    List<Widget> children,
    bool isDark,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? Colors.black.withOpacity(0.2) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required bool isDark,
    bool isDestructive = false,
  }) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: isDestructive
              ? AppColors.error.withOpacity(0.1)
              : AppColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: isDestructive ? AppColors.error : AppColors.primary,
          size: 24,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: isDestructive ? FontWeight.bold : FontWeight.normal,
          color: isDestructive
              ? AppColors.error
              : (isDark ? AppColors.textDark : AppColors.charcoalGrey),
          fontFamily: 'PlusJakartaSans',
        ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: isDark ? AppColors.textDark : AppColors.charcoalGrey,
        size: 28,
      ),
      onTap: onTap,
    );
  }
}

