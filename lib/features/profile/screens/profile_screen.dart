import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../features/auth/providers/auth_provider.dart';
import '../../listing/screens/add_listing_screen.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.profile),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await ref.read(authNotifierProvider.notifier).signOut();
              if (context.mounted) {
                Navigator.pushReplacementNamed(context, '/login');
              }
            },
          ),
        ],
      ),
      body: authState.when(
        data: (profile) {
          if (profile == null) {
            return const Center(child: Text('Non connecté'));
          }
          
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Profil
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: profile.avatarUrl != null
                            ? NetworkImage(profile.avatarUrl!)
                            : null,
                        child: profile.avatarUrl == null
                            ? const Icon(Icons.person, size: 50)
                            : null,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        profile.fullName ?? profile.email,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (profile.location != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          profile.location!,
                          style: const TextStyle(color: AppColors.textSecondary),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Actions
              ListTile(
                leading: const Icon(Icons.add_circle_outline),
                title: const Text(AppStrings.addListing),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AddListingScreen()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.book),
                title: const Text(AppStrings.myBookings),
                onTap: () {
                  // Naviguer vers les réservations
                },
              ),
              ListTile(
                leading: const Icon(Icons.favorite),
                title: const Text(AppStrings.favorites),
                onTap: () {
                  // Naviguer vers les favoris
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Paramètres'),
                onTap: () {
                  // Naviguer vers les paramètres
                },
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Erreur: $error')),
      ),
    );
  }
}

