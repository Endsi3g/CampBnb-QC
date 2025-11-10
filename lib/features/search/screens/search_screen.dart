import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              decoration: BoxDecoration(
                color: (isDark ? AppColors.backgroundDark : AppColors.backgroundLight)
                    .withOpacity(0.8),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Campbnb Québec',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: isDark ? AppColors.offWhite : AppColors.charcoal,
                            fontFamily: 'PlusJakartaSans',
                          ),
                        ),
                      ),
                      Icon(
                        Icons.menu,
                        size: 24,
                        color: isDark ? AppColors.offWhite : AppColors.charcoal,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Search Bar
                  Container(
                    height: 56,
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.charcoal.withOpacity(0.5) : AppColors.woodBeige,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16, right: 8),
                          child: Icon(
                            Icons.search,
                            color: AppColors.forestGreen,
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Où voulez-vous camper?',
                              hintStyle: TextStyle(
                                color: AppColors.forestGreen.withOpacity(0.7),
                                fontFamily: 'PlusJakartaSans',
                              ),
                              border: InputBorder.none,
                            ),
                            style: TextStyle(
                              color: isDark ? AppColors.offWhite : AppColors.charcoal,
                              fontFamily: 'PlusJakartaSans',
                            ),
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
                        _buildFilterChip('Type de camping', false, isDark),
                        const SizedBox(width: 8),
                        _buildFilterChip('Équipements', false, isDark),
                        const SizedBox(width: 8),
                        _buildFilterChip('Prix', true, isDark),
                        const SizedBox(width: 8),
                        _buildFilterChip('Région', false, isDark),
                        const SizedBox(width: 8),
                        _buildFilterChip('Plus de filtres', false, isDark, icon: Icons.tune),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Map View
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: NetworkImage(
                              'https://lh3.googleusercontent.com/aida-public/AB6AXuDVcfnwwNlf-_glIAofsRi5bAuV8EybCEe-J3gedNOiyW7CQx8Qi_ikMOP5lYkaCefmFr6nJBK74Niqr3plbtfWEKep1yBYO-DhiiFnQOkzlLXT7AZxLJ2V9QRIyncri6d9Ltz2hnMsoSvLQYTO7gPOLA8tBOV_Br5P_O6xSoH_c-0cSfo41tn8SqxTptbhcldU7UfuH6onDwnFLHEF4x6n31JvPjCD2nepnz2YyqJoDbRQbpoPhUBtD_A-riGVPjJY0F7-QJ22vnXR',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    // Listing Cards
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          _buildSearchCard(context, isDark),
                          const SizedBox(height: 16),
                          _buildSearchCard(context, isDark, isFavorite: true),
                          const SizedBox(height: 16),
                          _buildSearchCard(context, isDark),
                        ],
                      ),
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // Floating View Toggle
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 24),
        decoration: BoxDecoration(
          color: isDark ? AppColors.woodBeige : AppColors.charcoal,
          borderRadius: BorderRadius.circular(9999),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: isDark ? AppColors.charcoal : AppColors.woodBeige,
                borderRadius: BorderRadius.circular(9999),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.view_list,
                    size: 20,
                    color: isDark ? AppColors.offWhite : AppColors.charcoal,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Liste',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: isDark ? AppColors.offWhite : AppColors.charcoal,
                      fontFamily: 'PlusJakartaSans',
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.map,
                    size: 20,
                    color: isDark ? AppColors.charcoal : AppColors.offWhite,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Carte',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: isDark ? AppColors.charcoal : AppColors.offWhite,
                      fontFamily: 'PlusJakartaSans',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildFilterChip(String label, bool isSelected, bool isDark, {IconData? icon}) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: isSelected
            ? AppColors.forestGreen
            : (isDark ? AppColors.charcoal.withOpacity(0.5) : AppColors.woodBeige),
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: 20,
              color: isSelected
                  ? AppColors.offWhite
                  : (isDark ? AppColors.offWhite : AppColors.charcoal),
            ),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isSelected
                  ? AppColors.offWhite
                  : (isDark ? AppColors.offWhite : AppColors.charcoal),
              fontFamily: 'PlusJakartaSans',
            ),
          ),
          if (!isSelected) ...[
            const SizedBox(width: 4),
            Icon(
              Icons.expand_more,
              size: 20,
              color: isDark ? AppColors.offWhite : AppColors.charcoal,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSearchCard(BuildContext context, bool isDark, {bool isFavorite = false}) {
    return GestureDetector(
      onTap: () => context.push('/listing/1'),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? AppColors.charcoal.withOpacity(0.5) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.network(
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuCnmOXw3m1P2aLvYPFLhPWcGEDpsfbAxKiurMHlJcw4KIvthJ_3DDFnhd5XTTviaduoJh6CXbLDo1BWqtjVTmC2K00yL6P7-IQ9jNfpfQWpZww90e61__DoBHdIGYD_gIJoLOHpXJjPTtRV2BX0tRiv_MqkoTDM_8er29EIr2RIyrkvuI87voLkTFhL9Xd3eN57KBeEqNBBIgXNQU4_iTdDrKiUavCNRG8OKkqt8TQ0aATWb8_RjqBox0YA7ma6JB0LGUo0ELrOvtM_',
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Camping de la Forêt',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDark ? AppColors.offWhite : AppColors.charcoal,
                      fontFamily: 'PlusJakartaSans',
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Parc National de la Jacques-Cartier',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.forestGreen,
                      fontFamily: 'PlusJakartaSans',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 16,
                        color: AppColors.forestGreen,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '4.8',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.forestGreen,
                          fontFamily: 'PlusJakartaSans',
                        ),
                      ),
                      Text(
                        ' (123 avis)',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.forestGreen.withOpacity(0.8),
                          fontFamily: 'PlusJakartaSans',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$45 / nuit',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isDark ? AppColors.offWhite : AppColors.charcoal,
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
}
