import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';

class OnboardingScreen3 extends StatelessWidget {
  const OnboardingScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      body: Column(
        children: [
          // Header Image
          Expanded(
            flex: 3,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuC40eDbBF3vPmi0c9YwEu6xnSrxc-wr3RO1S1-5HQgXRwtnfhlBffxO79Z4sHrjlvWAVdT1GPPSLJSeF1QtcG-8sT96XxY8jY1mvfITa1dfitjV5YfucwNqj42-38oq7ZwgZzrtYuR_ftflZcMuK_YmxXwkApcdnzsiR0DaBmC4fGT0yfNqG42R58LvliWU_Ue_hQhH3ZYgTMx2X4NSfdF40V8eSiM_3KMFTwW-L5lWmwe4ErC_08hAMHRT3xQ8Gw0MbeZq_R4bKHj8',
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
                      Colors.black.withOpacity(0.6),
                    ],
                  ),
                ),
                padding: const EdgeInsets.all(24),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Devenez hôte sur Campbnb',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFF5F5F5),
                        height: 1.2,
                        fontFamily: 'PlusJakartaSans',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Content
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Gagnez un revenu supplémentaire et partagez votre amour de la nature en inscrivant facilement votre propriété. Rejoignez notre communauté et aidez les autres à découvrir le grand air.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: isDark ? const Color(0xFFF5F5F5) : const Color(0xFF131811),
                      fontFamily: 'PlusJakartaSans',
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Buttons
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () => context.go('/home'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9999),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Commencer',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.015,
                          fontFamily: 'PlusJakartaSans',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: OutlinedButton(
                      onPressed: () => context.go('/listing/add/step1'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF3A7CA5),
                        side: const BorderSide(
                          color: Color(0xFFD9B48F),
                          width: 1,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9999),
                        ),
                      ),
                      child: const Text(
                        'Commencer en tant qu\'hôte',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.015,
                          fontFamily: 'PlusJakartaSans',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Page Indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: isDark ? Colors.grey.shade700 : const Color(0xFFDEE6DB),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: isDark ? Colors.grey.shade700 : const Color(0xFFDEE6DB),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
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
    );
  }
}

