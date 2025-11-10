import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends State<NotificationSettingsScreen> {
  final Map<String, bool> _pushNotifications = {
    'Messages': true,
    'Confirmations': true,
    'Modifications': false,
    'Sécurité': true,
    'Promotions': false,
  };

  final Map<String, bool> _emailNotifications = {
    'Messages': false,
    'Confirmations': true,
    'Évaluations': true,
    'Promotions': false,
    'Résumé': false,
  };

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
            color: isDark ? AppColors.textPrimary : AppColors.textPrimary,
          ),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Paramètres de notification',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : AppColors.textPrimary,
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
            // Push Notifications Section
            Text(
              'NOTIFICATIONS PUSH',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
                fontFamily: 'PlusJakartaSans',
              ),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: isDark ? Colors.white.withOpacity(0.05) : Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _buildNotificationItem(
                    'Messages des hôtes/voyageurs',
                    'Recevez des messages instantanés.',
                    _pushNotifications['Messages'] ?? false,
                    (value) {
                      setState(() {
                        _pushNotifications['Messages'] = value ?? false;
                      });
                    },
                    isDark,
                  ),
                  Divider(height: 1, color: Colors.grey.shade300),
                  _buildNotificationItem(
                    'Confirmations et rappels',
                    'Alertes pour vos réservations à venir.',
                    _pushNotifications['Confirmations'] ?? false,
                    (value) {
                      setState(() {
                        _pushNotifications['Confirmations'] = value ?? false;
                      });
                    },
                    isDark,
                  ),
                  Divider(height: 1, color: Colors.grey.shade300),
                  _buildNotificationItem(
                    'Modifications des réservations',
                    'Soyez informé de tout changement.',
                    _pushNotifications['Modifications'] ?? false,
                    (value) {
                      setState(() {
                        _pushNotifications['Modifications'] = value ?? false;
                      });
                    },
                    isDark,
                  ),
                  Divider(height: 1, color: Colors.grey.shade300),
                  _buildNotificationItem(
                    'Activité du compte et sécurité',
                    'Alertes de sécurité importantes.',
                    _pushNotifications['Sécurité'] ?? false,
                    (value) {
                      setState(() {
                        _pushNotifications['Sécurité'] = value ?? false;
                      });
                    },
                    isDark,
                  ),
                  Divider(height: 1, color: Colors.grey.shade300),
                  _buildNotificationItem(
                    'Promotions et nouveautés',
                    'Recevez nos dernières offres.',
                    _pushNotifications['Promotions'] ?? false,
                    (value) {
                      setState(() {
                        _pushNotifications['Promotions'] = value ?? false;
                      });
                    },
                    isDark,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            // Email Notifications Section
            Text(
              'NOTIFICATIONS PAR E-MAIL',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
                fontFamily: 'PlusJakartaSans',
              ),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: isDark ? Colors.white.withOpacity(0.05) : Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _buildNotificationItem(
                    'Messages des hôtes/voyageurs',
                    'Recevez des copies par e-mail.',
                    _emailNotifications['Messages'] ?? false,
                    (value) {
                      setState(() {
                        _emailNotifications['Messages'] = value ?? false;
                      });
                    },
                    isDark,
                  ),
                  Divider(height: 1, color: Colors.grey.shade300),
                  _buildNotificationItem(
                    'Confirmations de réservation',
                    'Recevez les reçus et détails.',
                    _emailNotifications['Confirmations'] ?? false,
                    (value) {
                      setState(() {
                        _emailNotifications['Confirmations'] = value ?? false;
                      });
                    },
                    isDark,
                  ),
                  Divider(height: 1, color: Colors.grey.shade300),
                  _buildNotificationItem(
                    'Rappels d\'évaluation',
                    'N\'oubliez pas de laisser un avis.',
                    _emailNotifications['Évaluations'] ?? false,
                    (value) {
                      setState(() {
                        _emailNotifications['Évaluations'] = value ?? false;
                      });
                    },
                    isDark,
                  ),
                  Divider(height: 1, color: Colors.grey.shade300),
                  _buildNotificationItem(
                    'Promotions et infolettres',
                    'Nouvelles et offres exclusives.',
                    _emailNotifications['Promotions'] ?? false,
                    (value) {
                      setState(() {
                        _emailNotifications['Promotions'] = value ?? false;
                      });
                    },
                    isDark,
                  ),
                  Divider(height: 1, color: Colors.grey.shade300),
                  _buildNotificationItem(
                    'Résumé du compte',
                    'Recevez des résumés périodiques.',
                    _emailNotifications['Résumé'] ?? false,
                    (value) {
                      setState(() {
                        _emailNotifications['Résumé'] = value ?? false;
                      });
                    },
                    isDark,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationItem(
    String title,
    String subtitle,
    bool value,
    ValueChanged<bool?> onChanged,
    bool isDark,
  ) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: isDark ? Colors.white : AppColors.textPrimary,
          fontFamily: 'PlusJakartaSans',
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 14,
          color: isDark ? Colors.grey.shade400 : AppColors.textSecondary,
          fontFamily: 'PlusJakartaSans',
        ),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: AppColors.primary,
      ),
    );
  }
}

