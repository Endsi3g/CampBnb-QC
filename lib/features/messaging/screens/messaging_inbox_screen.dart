import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';

class MessagingInboxScreen extends StatelessWidget {
  const MessagingInboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
        title: Text(
          'Inbox',
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
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: isDark ? Colors.grey.shade800 : Colors.white,
                borderRadius: BorderRadius.circular(9999),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 8),
                    child: Icon(
                      Icons.search,
                      color: isDark ? Colors.grey.shade400 : AppColors.textSecondary,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search messages or names',
                        hintStyle: TextStyle(
                          color: isDark ? Colors.grey.shade400 : AppColors.textSecondary,
                          fontFamily: 'PlusJakartaSans',
                        ),
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        color: isDark ? Colors.white : AppColors.textPrimary,
                        fontFamily: 'PlusJakartaSans',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Conversation List
          Expanded(
            child: ListView(
              children: [
                _buildConversationItem(
                  context,
                  imageUrl:
                      'https://lh3.googleusercontent.com/aida-public/AB6AXuBCKiTolPe5z5dE8lpUqpvLHM1SRhmQdmoRXPGrvRqjNx2FDGO_nqlnWVMozlr_EtI_aER1n895PlIZkU-B9_uvEz8-gEd_TsHkB_T7eIZjQC10OcdyBZmI8mdexQASD3b9HRJwid_OD4A7XflUL2tiLzsEVVebXa5fnbiWGJ5mmYT9teeIWuxgHCvY-6z9uSDkw_pnnNE6mkTA-Khx88vLRvffhQaV93g1lDBB1nwTOdvL6CdZpPewMPypkdxnl1b756myILdEV71Y',
                  name: 'Alexandre Tremblay',
                  message: 'Great, see you then! The site...',
                  time: '1h ago',
                  hasUnread: true,
                  isDark: isDark,
                ),
                _buildConversationItem(
                  context,
                  imageUrl:
                      'https://lh3.googleusercontent.com/aida-public/AB6AXuCgnAKbEr4IZ9OEPK2xFd44KL9QpBN7jUTsBX6lomXQkH1OhFm6-IVqnT0PyezUbUj-W6yfE4j3T2L6X2-6mY0Df-ffbo--SU_0di2FCmkqoCFEkSt7cIVdJGYPplz0YskcGE3v3lYE5SBKUzC2z1sIoIxZ0qA1vgRglAE7ceIaWPJUtjPZEeDNFzieNUa-b1aYfMEVgZDZaGoKyj5a52e1aHjwLxcRNjy71bmSDuXt0Fg3aZ187mCUX1oc-hTHI3PsGMiGUTLvhuJT',
                  name: 'Marie Leblanc',
                  message: 'Is the firewood included with the booking?',
                  time: 'Yesterday',
                  hasUnread: true,
                  isDark: isDark,
                ),
                _buildConversationItem(
                  context,
                  imageUrl:
                      'https://lh3.googleusercontent.com/aida-public/AB6AXuCsHkQVShcfmVUSc5ga4O3aVdzyeAay5Yi_knxMSjZ_-EhSvE7PLoxn9uzjXPFi2xwDTlrWt71h3IlVxDJ_UDV8_GsfGj9QDqQcwynE3pztWG-FRCFJ6eC0x7ej6JAG6oqbm_SsQ5nyP_dIlhZA2F0Fsl53ZyxE4BU9dDvR7tLdzalMRnn7sGkFbBqt4j-mQxfYSs6JQpDnZXmKx4-V-BZbqM_APiIbEcGL0_ozMiAX_--F2dK5wUeq2-bb4LcmC3bky5a1ltGjc7xK',
                  name: 'Camping Le Chêne',
                  message: 'Your booking for next weekend is confirmed.',
                  time: 'Oct 26',
                  hasUnread: false,
                  isDark: isDark,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 96,
        decoration: BoxDecoration(
          color: (isDark ? AppColors.backgroundDark : AppColors.backgroundLight).withOpacity(0.8),
          border: Border(
            top: BorderSide(color: Colors.grey.shade300),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.explore, 'Explore', false, isDark, onTap: () => context.push('/home')),
            _buildNavItem(Icons.favorite, 'Wishlists', false, isDark, onTap: () {
              // TODO: Navigate to favorites
            }),
            _buildNavItem(Icons.mail, 'Inbox', true, isDark),
            _buildNavItem(Icons.account_circle, 'Profile', false, isDark, onTap: () => context.push('/profile')),
          ],
        ),
      ),
    );
  }

  Widget _buildConversationItem(
    BuildContext context, {
    required String imageUrl,
    required String name,
    required String message,
    required String time,
    required bool hasUnread,
    required bool isDark,
  }) {
    return ListTile(
      leading: CircleAvatar(
        radius: 28,
        backgroundImage: NetworkImage(imageUrl),
      ),
      title: Text(
        name,
        style: TextStyle(
          fontSize: 16,
          fontWeight: hasUnread ? FontWeight.bold : FontWeight.w500,
          color: isDark ? Colors.white : AppColors.textPrimary,
          fontFamily: 'PlusJakartaSans',
        ),
      ),
      subtitle: Text(
        message,
        style: TextStyle(
          fontSize: 14,
          color: isDark ? Colors.grey.shade400 : AppColors.textSecondary,
          fontFamily: 'PlusJakartaSans',
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            time,
            style: TextStyle(
              fontSize: 12,
              color: isDark ? Colors.grey.shade400 : AppColors.textSecondary,
              fontFamily: 'PlusJakartaSans',
            ),
          ),
          if (hasUnread) ...[
            const SizedBox(height: 4),
            Container(
              width: 12,
              height: 12,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ],
      ),
      onTap: () => context.push('/chat/user1'),
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
                : (isDark ? Colors.grey.shade400 : AppColors.textSecondary),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected
                  ? AppColors.primary
                  : (isDark ? Colors.grey.shade400 : AppColors.textSecondary),
              fontFamily: 'PlusJakartaSans',
            ),
          ),
        ],
      ),
    );
  }
}

