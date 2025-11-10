import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final Map<String, bool> _expandedSections = {
    'bookings': true,
    'favorites': false,
    'badges': false,
  };

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 64,
                    backgroundImage: NetworkImage(
                      'https://lh3.googleusercontent.com/aida-public/AB6AXuDZmKRejsJYXkCSXJgG0CqHd1tQD3MKSwH3H1wiTQLcwU-9HZmCd7N3y_iK6fLLMtgHwfsd65WCFIEpCTuF-JcAvr1mC7E5FzlYL1--NtpM_8oQ9nZzUSLR8e0IFMJ2rPDiZQ7B3Lb6ovKQ0fizoZBlOOYSm1TOJok1asvv4rjC-MS5-8MjmtYjn9Lyxv8WNB9zntu6xP4JAkldFEDlk2rx2SG_q1Z4184wQDrqB_K5_kNzwRT5h1RAJR07p3_5ACKNlLNLTHe1ThAU',
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Alexandre Tremblay',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.charcoal,
                      fontFamily: 'PlusJakartaSans',
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Membre depuis Janvier 2023',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.forestGreen,
                      fontFamily: 'PlusJakartaSans',
                    ),
                  ),
                ],
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
                    child: Column(
                      children: [
                        _buildBookingItem(
                          imageUrl:
                              'https://lh3.googleusercontent.com/aida-public/AB6AXuB5YAqSEA6Wup9HgrbcWTJ-E71lM1WTG7plGulo74iFLGltnK9llDIl_1jw8ZWKW0y_6nkB9a6vCGeBjwUUChm0B_y9vJLADvIJ4a94vf7wLzH5a0_zI7AydtD2U7sjczK61JC-UhHQsOSnkHxzMsH7yuioN-7Qw5U8oyK7_kCN8MQLBovLNbnDE400pe800U2xGXUL-pbb0zLumlGaviIKuVivr1SEUGmd4atpTusUw56V5i1ls3F8Q5UFU0OCdA4xXWuTLARJFK7V',
                          title: 'Camping du Fjord',
                          dates: '12 Juin 2023 - 15 Juin 2023',
                          location: 'Saguenay, Québec',
                        ),
                        Divider(height: 1),
                        _buildBookingItem(
                          imageUrl:
                              'https://lh3.googleusercontent.com/aida-public/AB6AXuDMScF8I3M9Hmyc06PFHclg2koEwECT-NM2LNAifw2GnBeuQuhA8EmBrw_6oPIguNJ2jqTZEJr_IoE9mgrZkgZLpm0q8Gk14q9LHshk1ognyS0POUT3mp8fOyuqg7b-0TjkoossNtRkVdKLX5RCgG0CCcBKYZI7lFSBaCnexGhAafyizzvmuAGxWOjEMNRXZEzuBh-qzy_rcIItJ56WS1TNPS4u36kkMlRJClPubeTCezojzlAxcw4KO-Y7pVegs2Aogmi8z5c3vCVg',
                          title: 'Parc National de la Gaspésie',
                          dates: '22 Juillet 2023 - 25 Juillet 2023',
                          location: 'Gaspésie, Québec',
                        ),
                      ],
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
