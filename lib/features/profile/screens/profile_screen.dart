import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_colors.dart';
import '../providers/profile_provider.dart';
import '../../booking/providers/booking_provider.dart';
import '../../listing/providers/listing_provider.dart';
import '../../../repositories/favorite_repository.dart';
import '../../../repositories/profile_repository.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final Map<String, bool> _expandedSections = {
    'bookings': true,
    'favorites': false,
    'badges': false,
  };

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final profileAsync = ref.watch(currentProfileProvider);
    final bookingsAsync = ref.watch(userBookingsProvider);
    final favoritesAsync = ref.watch(favoriteListingsProvider);

    return Scaffold(
      backgroundColor: AppColors.woodBeige,
      appBar: AppBar(
        backgroundColor: AppColors.woodBeige,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.charcoal,
          ),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Profil',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.charcoal,
            fontFamily: 'PlusJakartaSans',
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () => context.push('/settings'),
            child: Text(
              'Modifier',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.forestGreen,
                fontFamily: 'PlusJakartaSans',
              ),
            ),
          ),
        ],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header
            Padding(
              padding: const EdgeInsets.all(16),
              child: profileAsync.when(
                data: (profile) {
                  if (profile == null) {
                    return const SizedBox.shrink();
                  }
                  return Column(
                    children: [
                      CircleAvatar(
                        radius: 64,
                        backgroundImage: profile.avatarUrl != null
                            ? NetworkImage(profile.avatarUrl!)
                            : null,
                        child: profile.avatarUrl == null
                            ? Text(
                                profile.fullName.isNotEmpty
                                    ? profile.fullName[0].toUpperCase()
                                    : 'U',
                                style: const TextStyle(fontSize: 32),
                              )
                            : null,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        profile.fullName,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.charcoal,
                          fontFamily: 'PlusJakartaSans',
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Membre depuis ${DateFormat('MMMM yyyy', 'fr').format(profile.createdAt)}',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.forestGreen,
                          fontFamily: 'PlusJakartaSans',
                        ),
                      ),
                    ],
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Text('Erreur: $error'),
              ),
            ),
            // Accordions
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildAccordion(
                    title: 'Historique des réservations',
                    isExpanded: _expandedSections['bookings'] ?? false,
                    onExpansionChanged: (value) {
                      setState(() {
                        _expandedSections['bookings'] = value;
                      });
                    },
                    child: bookingsAsync.when(
                      data: (bookings) {
                        if (bookings.isEmpty) {
                          return Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              'Aucune réservation',
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontFamily: 'PlusJakartaSans',
                              ),
                            ),
                          );
                        }
                        return Column(
                          children: [
                            ...bookings.asMap().entries.map((entry) {
                              final booking = entry.value;
                              final isLast = entry.key == bookings.length - 1;
                              return Column(
                                children: [
                                  FutureBuilder(
                                    future: ref.read(listingDetailsProvider(booking.listingId).future),
                                    builder: (context, snapshot) {
                                      final listing = snapshot.data;
                                      return _buildBookingItem(
                                        imageUrl: listing?.imageUrl ?? '',
                                        title: listing?.title ?? 'Listing',
                                        dates: '${DateFormat('dd MMM yyyy', 'fr').format(booking.checkIn)} - ${DateFormat('dd MMM yyyy', 'fr').format(booking.checkOut)}',
                                        location: '${listing?.city ?? ''}, ${listing?.region ?? ''}',
                                      );
                                    },
                                  ),
                                  if (!isLast) Divider(height: 1),
                                ],
                              );
                            }),
                          ],
                        );
                      },
                      loading: () => const Center(child: CircularProgressIndicator()),
                      error: (error, stack) => Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          'Erreur: $error',
                          style: TextStyle(color: AppColors.error),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildAccordion(
                    title: 'Liste de favoris',
                    isExpanded: _expandedSections['favorites'] ?? false,
                    onExpansionChanged: (value) {
                      setState(() {
                        _expandedSections['favorites'] = value;
                      });
                    },
                    child: _buildFavoriteItem(
                      imageUrl:
                          'https://lh3.googleusercontent.com/aida-public/AB6AXuAEmwZQYGU2MEjuD4vz-Wiws1CVxOFpI6Jw6Qdkmq7tO7Vs7A7ky2-vc73G__Ttz3dBoOcKSLo7aiQ6y5JvuonnJGQeJFBBbhpg4Dm_CPZ4XyaTMEt34YwyMZSDYGHc5YV5fEF92QGMiV4wlDtCoPi8ubwwH49PvG8tT9S22bGV004KFlWsfdFhcZRqUOIi47Db5Q42pbUZH0GB6KsJMKgoYepl38MbsiQ8UnzmUazYHC_qOpGB8Ol58aBgXKT7A0gIulZiGvrhnDVS',
                      title: 'Chalets Mont-Sainte-Anne',
                      location: 'Beaupré, Québec',
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildAccordion(
                    title: 'Badges et Trophées',
                    isExpanded: _expandedSections['badges'] ?? false,
                    onExpansionChanged: (value) {
                      setState(() {
                        _expandedSections['badges'] = value;
                      });
                    },
                    child: _buildBadgesGrid(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccordion({
    required String title,
    required bool isExpanded,
    required ValueChanged<bool> onExpansionChanged,
    required Widget child,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.offWhite,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ExpansionTile(
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.charcoal,
            fontFamily: 'PlusJakartaSans',
          ),
        ),
        initiallyExpanded: isExpanded,
        onExpansionChanged: onExpansionChanged,
        trailing: Icon(
          Icons.expand_more,
          color: AppColors.charcoal,
        ),
        children: [child],
      ),
    );
  }

  Widget _buildBookingItem({
    required String imageUrl,
    required String title,
    required String dates,
    required String location,
  }) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          imageUrl,
          width: 60,
          height: 60,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.charcoal,
          fontFamily: 'PlusJakartaSans',
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            dates,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.forestGreen,
              fontFamily: 'PlusJakartaSans',
            ),
          ),
          Text(
            location,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade500,
              fontFamily: 'PlusJakartaSans',
            ),
          ),
        ],
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: AppColors.charcoal,
      ),
      onTap: () {
        // TODO: Navigate to booking details
        // context.push('/booking/details');
      },
    );
  }

  Widget _buildFavoriteItem({
    required String imageUrl,
    required String title,
    required String location,
  }) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          imageUrl,
          width: 60,
          height: 60,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.charcoal,
          fontFamily: 'PlusJakartaSans',
        ),
      ),
      subtitle: Text(
        location,
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey.shade500,
          fontFamily: 'PlusJakartaSans',
        ),
      ),
      trailing: Icon(
        Icons.favorite,
        color: AppColors.lakeBlue,
        size: 28,
      ),
      onTap: () {
        // TODO: Navigate to listing details
        // context.push('/listing/1');
      },
    );
  }

  Widget _buildBadgesGrid() {
    final badges = [
      {'icon': Icons.nights_stay, 'label': 'Première Nuit', 'earned': true},
      {'icon': Icons.forest, 'label': 'Explorateur Forestier', 'earned': true},
      {'icon': Icons.loyalty, 'label': 'Fidèle Campeur', 'earned': false},
      {'icon': Icons.kayaking, 'label': 'Aventurier du Lac', 'earned': false},
      {'icon': Icons.hiking, 'label': 'Grand Randonneur', 'earned': false},
    ];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: badges.length,
        itemBuilder: (context, index) {
          final badge = badges[index];
          final earned = badge['earned'] as bool;

          return Opacity(
            opacity: earned ? 1.0 : 0.5,
            child: Column(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: earned
                        ? AppColors.trophyGold.withOpacity(0.2)
                        : Colors.grey.shade200,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    badge['icon'] as IconData,
                    size: 32,
                    color: earned ? AppColors.trophyGold : Colors.grey.shade500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  badge['label'] as String,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.charcoal,
                    fontFamily: 'PlusJakartaSans',
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
