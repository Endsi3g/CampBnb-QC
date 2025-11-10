import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';

class ListingDetailScreen extends StatelessWidget {
  final String listingId;

  const ListingDetailScreen({super.key, required this.listingId});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Image
                Container(
                  height: 320,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://lh3.googleusercontent.com/aida-public/AB6AXuBpj9YzTxoxmJbwHm1pEzf6gp7ck-uWUE6ED6wXYLYgaxtgZMkDMJcB0NmQYm0HbjaviZJS_cRCKv6h9pnu-O1hbliX5c5A4U5H0x-kphjISoUVYRekqjssb0g_0RkmNZYBkZUo-i2MLA6XEu58JldClD6sgjcotVMw_7qzz3Uf_qlMnb9J14bWY-vqvlVRd0r_xn__ivY9PsOisPuF6tjCoNEHnZNUTrjRaJLdFxtT-qd9QWubzdLaNLwqolcRPaUTbKQGXZzeoNLk',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.4),
                            ],
                          ),
                        ),
                      ),
                      // Image Indicators
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                            Container(
                              width: 24,
                              height: 8,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.5),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.5),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.5),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.5),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Content
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Grand Pin',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: isDark ? AppColors.textDark : AppColors.textLight,
                          fontFamily: 'PlusJakartaSans',
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Parc national de la Mauricie',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.secondary,
                          fontFamily: 'PlusJakartaSans',
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Un paragraphe bref et invitant décrivant les caractéristiques uniques et l\'atmosphère du camping. Conçu pour inspirer et informer les visiteurs potentiels sur ce qui rend ce lieu spécial.',
                        style: TextStyle(
                          fontSize: 16,
                          color: isDark ? AppColors.textDark : AppColors.textLight,
                          fontFamily: 'PlusJakartaSans',
                        ),
                      ),
                      const SizedBox(height: 24),
                      Divider(
                        color: isDark
                            ? AppColors.textDark.withOpacity(0.2)
                            : AppColors.textLight.withOpacity(0.2),
                      ),
                      const SizedBox(height: 24),
                      // Key Info Grid
                      GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 1.5,
                        children: [
                          _buildInfoCard(
                            icon: Icons.forest,
                            label: 'Type',
                            value: 'Prêt-à-camper',
                            isDark: isDark,
                          ),
                          _buildInfoCard(
                            icon: Icons.group,
                            label: 'Capacité',
                            value: '4 personnes',
                            isDark: isDark,
                          ),
                          _buildInfoCard(
                            icon: Icons.credit_card,
                            label: 'Arrhes',
                            value: 'Dépôt de 50%',
                            isDark: isDark,
                          ),
                          _buildInfoCard(
                            icon: Icons.gavel,
                            label: 'Règlement',
                            value: 'Voir les règles',
                            isDark: isDark,
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Divider(
                        color: isDark
                            ? AppColors.textDark.withOpacity(0.2)
                            : AppColors.textLight.withOpacity(0.2),
                      ),
                      const SizedBox(height: 24),
                      // Équipements
                      Text(
                        'Équipements',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: isDark ? AppColors.textDark : AppColors.textLight,
                          fontFamily: 'PlusJakartaSans',
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildAmenityItem(Icons.table_restaurant, 'Table à pique-nique', isDark),
                      const SizedBox(height: 16),
                      _buildAmenityItem(Icons.local_fire_department, 'Foyer pour feu de camp', isDark),
                      const SizedBox(height: 16),
                      _buildAmenityItem(Icons.water_drop, 'Accès à l\'eau potable', isDark),
                      const SizedBox(height: 16),
                      _buildAmenityItem(Icons.wc, 'Toilettes à proximité', isDark),
                      const SizedBox(height: 16),
                      _buildAmenityItem(Icons.forest, 'Espace pour tente', isDark),
                      const SizedBox(height: 100                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
          // Top App Bar
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => context.pop(),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.ios_share, color: Colors.white),
                          onPressed: () {},
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.favorite_border, color: Colors.white),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      // Sticky Footer
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: (isDark ? AppColors.backgroundDark : AppColors.backgroundLight).withOpacity(0.8),
          border: Border(
            top: BorderSide(
              color: isDark
                  ? AppColors.textDark.withOpacity(0.1)
                  : AppColors.textLight.withOpacity(0.1),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '65\$',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: isDark ? AppColors.textDark : AppColors.textLight,
                    fontFamily: 'PlusJakartaSans',
                  ),
                ),
                Text(
                  ' / nuit',
                  style: TextStyle(
                    fontSize: 16,
                    color: isDark
                        ? AppColors.textDark.withOpacity(0.7)
                        : AppColors.textLight.withOpacity(0.7),
                    fontFamily: 'PlusJakartaSans',
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () => context.push('/reservation/$listingId'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9999),
                ),
              ),
              child: const Text(
                'Réserver',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'PlusJakartaSans',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String label,
    required String value,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? Colors.black.withOpacity(0.2) : AppColors.backgroundLight,
        border: Border.all(
          color: isDark
              ? AppColors.textDark.withOpacity(0.1)
              : AppColors.textLight.withOpacity(0.1),
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            icon,
            size: 32,
            color: AppColors.secondary,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  color: isDark
                      ? AppColors.textDark.withOpacity(0.7)
                      : AppColors.textLight.withOpacity(0.7),
                  fontFamily: 'PlusJakartaSans',
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.textDark : AppColors.textLight,
                  fontFamily: 'PlusJakartaSans',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAmenityItem(IconData icon, String label, bool isDark) {
    return Row(
      children: [
        Icon(
          icon,
          size: 24,
          color: AppColors.secondary,
        ),
        const SizedBox(width: 16),
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: isDark ? AppColors.textDark : AppColors.textLight,
            fontFamily: 'PlusJakartaSans',
          ),
        ),
      ],
    );
  }
}
