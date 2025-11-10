import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../features/search/providers/search_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final listingsAsync = ref.watch(searchListingsProvider());

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            // Top App Bar
            Container(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              decoration: BoxDecoration(
                color: (isDark ? AppColors.backgroundDark : AppColors.backgroundLight)
                    .withOpacity(0.8),
              ),
              child: Column(
                children: [
                  // Header
                  Row(
                    children: [
                      Icon(
                        Icons.forest,
                        size: 48,
                        color: isDark ? AppColors.backgroundLight : AppColors.primary,
                      ),
                      Expanded(
                        child: Text(
                          'Campbnb Québec',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isDark ? AppColors.backgroundLight : AppColors.primary,
                            fontFamily: 'PlusJakartaSans',
                          ),
                        ),
                      ),
                      const SizedBox(width: 48),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Search Bar
                  Container(
                    height: 56,
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
                      borderRadius: BorderRadius.circular(9999),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 8),
                          child: Icon(
                            Icons.search,
                            color: isDark
                                ? AppColors.textSecondary
                                : AppColors.textSecondary,
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Lieu, hébergement, dates',
                              hintStyle: TextStyle(
                                color: isDark
                                    ? AppColors.textSecondary
                                    : AppColors.textSecondary,
                                fontFamily: 'PlusJakartaSans',
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                            ),
                            style: TextStyle(
                              color: isDark ? AppColors.textPrimary : AppColors.textPrimary,
                              fontFamily: 'PlusJakartaSans',
                            ),
                            onTap: () => context.push('/search'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Filter Chips
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildFilterChip(
                          label: 'Prix',
                          isSelected: false,
                          isDark: isDark,
                        ),
                        const SizedBox(width: 12),
                        _buildFilterChip(
                          label: 'Type',
                          isSelected: true,
                          isDark: isDark,
                        ),
                        const SizedBox(width: 12),
                        _buildFilterChip(
                          label: 'Région',
                          isSelected: false,
                          isDark: isDark,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Listings
            Expanded(
              child: listingsAsync.when(
                data: (listings) {
                  if (listings.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.forest,
                            size: 64,
                            color: AppColors.textSecondary,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Aucun résultat',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontFamily: 'PlusJakartaSans',
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: listings.length,
                    itemBuilder: (context, index) {
                      final listing = listings[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: _buildListingCard(context, listing, isDark),
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(
                  child: Text('Erreur: $error'),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(context, isDark),
    );
  }

  Widget _buildFilterChip({
    required String label,
    required bool isSelected,
    required bool isDark,
  }) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: isSelected
            ? AppColors.primary
            : (isDark ? AppColors.surfaceDark : AppColors.surfaceLight),
        border: Border.all(
          color: AppColors.primary.withOpacity(isSelected ? 1 : 0.2),
        ),
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isSelected
                  ? Colors.white
                  : (isDark ? AppColors.textPrimary : AppColors.textPrimary),
              fontFamily: 'PlusJakartaSans',
            ),
          ),
          const SizedBox(width: 4),
          Icon(
            Icons.expand_more,
            size: 20,
            color: isSelected
                ? Colors.white.withOpacity(0.8)
                : (isDark ? AppColors.textSecondary : AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildListingCard(BuildContext context, dynamic listing, bool isDark) {
    return GestureDetector(
      onTap: () => context.push('/listing/${listing.id}'),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.network(
                    listing.imageUrl ?? '',
                    height: 192,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 192,
                        color: Colors.grey.shade300,
                        child: const Icon(Icons.image, size: 48),
                      );
                    },
                  ),
                ),
                // Badge
                if (listing.isPopular ?? false)
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.circular(9999),
                      ),
                      child: const Text(
                        'Populaire',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'PlusJakartaSans',
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          listing.title ?? 'Camping',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: isDark ? AppColors.textPrimary : AppColors.textPrimary,
                            fontFamily: 'PlusJakartaSans',
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          listing.location ?? 'Québec',
                          style: TextStyle(
                            fontSize: 14,
                            color: isDark ? AppColors.textSecondary : AppColors.textSecondary,
                            fontFamily: 'PlusJakartaSans',
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          listing.type ?? 'Tente',
                          style: TextStyle(
                            fontSize: 14,
                            color: isDark ? AppColors.textSecondary : AppColors.textSecondary,
                            fontFamily: 'PlusJakartaSans',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '\$${listing.price ?? 0}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isDark ? AppColors.primary : AppColors.primary,
                      fontFamily: 'PlusJakartaSans',
                    ),
                  ),
                  Text(
                    ' / nuit',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: isDark ? AppColors.textSecondary : AppColors.textSecondary,
                      fontFamily: 'PlusJakartaSans',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavBar(BuildContext context, bool isDark) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: (isDark ? AppColors.surfaceDark : AppColors.surfaceLight).withOpacity(0.8),
        border: Border(
          top: BorderSide(
            color: AppColors.primary.withOpacity(0.1),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            context,
            icon: Icons.home,
            label: 'Accueil',
            isSelected: true,
            isDark: isDark,
          ),
          _buildNavItem(
            context,
            icon: Icons.favorite,
            label: 'Favoris',
            isSelected: false,
            isDark: isDark,
            onTap: () {
              // TODO: Navigate to favorites screen
              // context.push('/favorites');
            },
          ),
          _buildNavItem(
            context,
            icon: Icons.book_online,
            label: 'Réservations',
            isSelected: false,
            isDark: isDark,
            onTap: () {
              // TODO: Navigate to bookings screen
              // context.push('/bookings');
            },
          ),
          _buildNavItem(
            context,
            icon: Icons.person,
            label: 'Profil',
            isSelected: false,
            isDark: isDark,
            onTap: () => context.push('/profile'),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required bool isSelected,
    required bool isDark,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 28,
            color: isSelected
                ? (isDark ? AppColors.backgroundLight : AppColors.primary)
                : (isDark ? AppColors.textSecondary : AppColors.textSecondary),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected
                  ? (isDark ? AppColors.backgroundLight : AppColors.primary)
                  : (isDark ? AppColors.textSecondary : AppColors.textSecondary),
              fontFamily: 'PlusJakartaSans',
            ),
          ),
        ],
      ),
    );
  }
}
