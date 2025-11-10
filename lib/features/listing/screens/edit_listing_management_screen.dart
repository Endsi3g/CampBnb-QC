import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';

class EditListingManagementScreen extends StatelessWidget {
  final String listingId;

  const EditListingManagementScreen({super.key, required this.listingId});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: isDark ? AppColors.cardDark : AppColors.cardLight,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? AppColors.backgroundLight : AppColors.textPrimary,
          ),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Gérer l\'annonce',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isDark ? AppColors.backgroundLight : AppColors.textPrimary,
            fontFamily: 'PlusJakartaSans',
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Header Image
          Container(
            height: 256,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  'https://lh3.googleusercontent.com/aida-public/AB6AXuChM2lyTlgff3t47rwyF71T5qUKmcudRpsuVNKDOtrAYdAIzjhZSYbE0Jv1t2nxP2qm0GfoYd9WDXliXWZn6gWMwgvCIYw5CQKGdlDqDny7VxtKgsfj6-6X5yPfGAl-KX5GzuKAaswh6r2-gDy-RGEmTNN7tWv8AJrXDkTwAu5lIxADRii2HQ0RghcjhfgLRgmcxlCudgFqSvSamNFxNNGf_U0ot1HAwqRWiuuelX8Pm0yKJIkEHmaqg1QxfGxAjJvqYpwNJ6psT9sq',
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.5),
                  ],
                ),
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Chalet rustique au bord du lac Memphrémagog',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'PlusJakartaSans',
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Management Menu
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildMenuItem(
                  context,
                  icon: Icons.info,
                  title: 'Informations générales',
                  onTap: () {},
                  isDark: isDark,
                ),
                const SizedBox(height: 8),
                _buildMenuItem(
                  context,
                  icon: Icons.photo_camera,
                  title: 'Photos et Vidéos',
                  onTap: () {},
                  isDark: isDark,
                ),
                const SizedBox(height: 8),
                _buildMenuItem(
                  context,
                  icon: Icons.outdoor_grill,
                  title: 'Équipements et Activités',
                  onTap: () {},
                  isDark: isDark,
                ),
                const SizedBox(height: 8),
                _buildMenuItem(
                  context,
                  icon: Icons.calendar_month,
                  title: 'Prix et Calendrier',
                  onTap: () {},
                  isDark: isDark,
                ),
                const SizedBox(height: 8),
                _buildMenuItem(
                  context,
                  icon: Icons.gavel,
                  title: 'Règlement',
                  onTap: () {},
                  isDark: isDark,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? AppColors.cardDark : AppColors.cardLight,
          border: Border(
            top: BorderSide(
              color: Colors.grey.shade200.withOpacity(0.5),
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  side: BorderSide(color: AppColors.primary),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9999),
                  ),
                ),
                child: const Text(
                  'Mettre en pause',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'PlusJakartaSans',
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: isDark ? AppColors.backgroundDark : Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9999),
                  ),
                ),
                child: const Text(
                  'Prévisualiser',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'PlusJakartaSans',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : AppColors.cardLight,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: isDark ? Colors.black.withOpacity(0.2) : AppColors.backgroundLight,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: isDark ? AppColors.backgroundLight : AppColors.textPrimary,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            color: isDark ? AppColors.backgroundLight : AppColors.textPrimary,
            fontFamily: 'PlusJakartaSans',
          ),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: isDark
              ? AppColors.backgroundLight.withOpacity(0.7)
              : AppColors.textPrimary.withOpacity(0.7),
        ),
        onTap: onTap,
      ),
    );
  }
}

