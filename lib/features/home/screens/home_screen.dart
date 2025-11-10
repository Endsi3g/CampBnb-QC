import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../shared/widgets/listing_card.dart';
import '../../../features/search/providers/search_provider.dart';
import '../../listing/screens/listing_detail_screen.dart';
import '../../ai/screens/ai_chat_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listingsAsync = ref.watch(searchListingsProvider());
    
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.home),
        actions: [
          IconButton(
            icon: const Icon(Icons.chat_bubble_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AiChatScreen()),
              );
            },
          ),
        ],
      ),
      body: listingsAsync.when(
        data: (listings) {
          if (listings.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.camping, size: 64, color: AppColors.textSecondary),
                  const SizedBox(height: 16),
                  Text(
                    AppStrings.noResults,
                    style: TextStyle(color: AppColors.textSecondary),
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
                child: ListingCard(
                  listing: listing,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ListingDetailScreen(listingId: listing.id),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Erreur: $error'),
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(context),
    );
  }
  
  Widget _buildBottomNavBar(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: AppStrings.home,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: AppStrings.search,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border),
          label: AppStrings.favorites,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: AppStrings.profile,
        ),
      ],
      onTap: (index) {
        switch (index) {
          case 0:
            // Déjà sur home
            break;
          case 1:
            Navigator.pushNamed(context, '/search');
            break;
          case 2:
            // Favoris (à implémenter)
            break;
          case 3:
            Navigator.pushNamed(context, '/profile');
            break;
        }
      },
    );
  }
}

