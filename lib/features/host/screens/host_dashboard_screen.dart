import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';

class HostDashboardScreen extends StatelessWidget {
  const HostDashboardScreen({super.key});

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
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(
                          'https://lh3.googleusercontent.com/aida-public/AB6AXuBdLykCUG7LRvfrImzpdLTLmIMOZVtwgf6vW4Chn9LXiUMmFQcJlQwWNXcKhXXd14vk8iH-FtYJ2ZmUWoGMw2dvI2dzGIs--NW9jlYpOBMQ8J5Lxn4wfzGDhL6JOPsd3P0kk743eHFKbvQLURC9fUbfSUrbZWyjvl0LVlotGK9BXEv9-bQJZMl5B49R1pPAkEgfK866l0brN_BU_f9yu2nk1ic61M7gimE9tiQ3M0TYDQBiXpst-pA8jZS2JvkJIFZYTDXPol_BoP4q',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Bonjour, Marie!',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: isDark ? AppColors.textDark : AppColors.textLight,
                      fontFamily: 'PlusJakartaSans',
                    ),
                  ),
                ],
              ),
            ),
            // Stats
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      'Revenus (30 jours)',
                      '\$1,250',
                      '+15.2%',
                      isDark,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      'Vues totales',
                      '2,800',
                      '+8.5%',
                      isDark,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      'Nouvelles demandes',
                      '4',
                      '+20%',
                      isDark,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Listings Section
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Vos Annonces',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: isDark ? AppColors.textDark : AppColors.textLight,
                        fontFamily: 'PlusJakartaSans',
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildListingCard(
                      context,
                      title: 'Bord de l\'eau à Sutton',
                      status: 'Actif',
                      statusColor: AppColors.primary,
                      imageUrl:
                          'https://lh3.googleusercontent.com/aida-public/AB6AXuAHrf-1SaldEurD1QUTnIu7puhJkFQdtrPKun6_G3OQ6LtdgNXsGWVgYTFQl_lMmufd2fq4M2R6sUomp9M7Kgp1MVAKrpQqlptGgErpdSKcCLDL-H0dcQFtIgTyttCwgemrxnjYQWHPZjCNpsEU87qLJzKQ0IZNO9HmX3YD21ThH2UItNV-WKGrNZQKIQCRgxoMTAuAX_oe9jzrXGw6yUjv8oAt83q8roym1g_poMP01UeNtIvSV63RzztRX4_Qeq6jD6MMUCqqmOth',
                      views: '1.2k',
                      messages: '5',
                      bookings: '8',
                      isDark: isDark,
                    ),
                    const SizedBox(height: 16),
                    _buildListingCard(
                      context,
                      title: 'Forêt enchantée à Magog',
                      status: 'En attente',
                      statusColor: Colors.grey.shade500,
                      imageUrl:
                          'https://lh3.googleusercontent.com/aida-public/AB6AXuBqgVccRQK3cpEPiOq3dSZF1Pgj1q3zQXRq10EMjMJ4M2J2qhHu1QYhskfPfO70b6x34v_w4lUbXZnVIomSBznoph_Xojfbs-1jxZ7MiXwevWQwgVMQ72qMJixsrbU0bKGe3n_QI5zsxdasV7kWaeSQiMVb2pPQlJHjoo6c7IbOoqaY94jvYuCNApUfrgpCb-mz77QsbUX3voNkDQULW8rYPQIGpa-7FDc0mejfZi6OB7xOPnKBNYzfgYk4r_9KpOmT4wG1Wt_qGT5I',
                      views: '450',
                      messages: '1',
                      bookings: '2',
                      isDark: isDark,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/listing/add/step1'),
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          'Ajouter une annonce',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'PlusJakartaSans',
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(
          color: (isDark ? AppColors.backgroundDark : AppColors.backgroundLight).withOpacity(0.8),
          border: Border(
            top: BorderSide(
              color: AppColors.accent.withOpacity(0.5),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.dashboard, 'Tableau de bord', true, isDark),
            _buildNavItem(Icons.calendar_today, 'Calendrier', false, isDark),
            _buildNavItem(Icons.chat, 'Messages', false, isDark, onTap: () => context.push('/messages')),
            _buildNavItem(Icons.person, 'Profil', false, isDark, onTap: () => context.push('/profile')),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value, String change, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.accent.withOpacity(0.3),
        border: Border.all(color: AppColors.accent),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: isDark ? AppColors.textDark : AppColors.textLight,
              fontFamily: 'PlusJakartaSans',
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: isDark ? AppColors.textDark : AppColors.textLight,
              fontFamily: 'PlusJakartaSans',
            ),
          ),
          const SizedBox(height: 4),
          Text(
            change,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.primary,
              fontFamily: 'PlusJakartaSans',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListingCard(
    BuildContext context, {
    required String title,
    required String status,
    required Color statusColor,
    required String imageUrl,
    required String views,
    required String messages,
    required String bookings,
    required bool isDark,
  }) {
    return GestureDetector(
      onTap: () => context.push('/listing/edit/1'),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? Colors.grey.shade800 : Colors.white,
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
          children: [
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
                          title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: isDark ? AppColors.textDark : AppColors.textLight,
                            fontFamily: 'PlusJakartaSans',
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          status,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: statusColor,
                            fontFamily: 'PlusJakartaSans',
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: AppColors.accent.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(9999),
                          ),
                          child: Text(
                            'Voir les détails',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: isDark ? AppColors.textDark : AppColors.textLight,
                              fontFamily: 'PlusJakartaSans',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      imageUrl,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            Divider(height: 1, color: AppColors.accent.withOpacity(0.5)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatItem(Icons.visibility, views, isDark),
                  _buildStatItem(Icons.chat_bubble, messages, isDark),
                  _buildStatItem(Icons.calendar_month, bookings, isDark),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String value, bool isDark) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.secondary),
        const SizedBox(width: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: AppColors.secondary,
            fontFamily: 'PlusJakartaSans',
          ),
        ),
      ],
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isSelected, bool isDark, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isSelected
                ? AppColors.primary
                : (isDark ? Colors.grey.shade400 : Colors.grey.shade500),
            size: isSelected ? 28 : 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              color: isSelected
                  ? AppColors.primary
                  : (isDark ? Colors.grey.shade400 : Colors.grey.shade500),
              fontFamily: 'PlusJakartaSans',
            ),
          ),
        ],
      ),
    );
  }
}

