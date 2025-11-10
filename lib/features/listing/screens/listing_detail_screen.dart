import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../features/listing/providers/listing_provider.dart';
import '../../booking/screens/booking_screen.dart';

class ListingDetailScreen extends ConsumerWidget {
  final String listingId;
  
  const ListingDetailScreen({
    super.key,
    required this.listingId,
  });
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listingAsync = ref.watch(listingDetailsProvider(listingId));
    
    return Scaffold(
      body: listingAsync.when(
        data: (listing) {
          if (listing == null) {
            return const Center(child: Text('Annonce non trouvée'));
          }
          
          return CustomScrollView(
            slivers: [
              // AppBar avec photos
              SliverAppBar(
                expandedHeight: 300,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: listing.hasPhotos
                      ? CarouselSlider(
                          options: CarouselOptions(
                            height: 300,
                            viewportFraction: 1.0,
                            autoPlay: true,
                          ),
                          items: listing.photos.map((photo) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Image.network(
                                  photo,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                );
                              },
                            );
                          }).toList(),
                        )
                      : Container(
                          color: AppColors.softGray,
                          child: const Icon(Icons.image, size: 64),
                        ),
                ),
              ),
              // Contenu
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Titre et prix
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              listing.title,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            '\$${listing.pricePerNight.toStringAsFixed(2)}/nuit',
                            style: TextStyle(
                              fontSize: 20,
                              color: AppColors.forestGreen,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Localisation
                      Row(
                        children: [
                          Icon(Icons.location_on, size: 16, color: AppColors.textSecondary),
                          const SizedBox(width: 4),
                          Text(
                            '${listing.city}, ${listing.region}',
                            style: TextStyle(color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Description
                      Text(
                        listing.description,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 24),
                      // Équipements
                      const Text(
                        'Équipements',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: listing.amenities.map((amenity) {
                          return Chip(
                            label: Text(amenity),
                            backgroundColor: AppColors.softGray,
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 24),
                      // Informations
                      _buildInfoRow('Type', listing.listingType),
                      _buildInfoRow('Voyageurs max', listing.maxGuests.toString()),
                      _buildInfoRow('Nuits min', listing.minNights.toString()),
                      if (listing.houseRules != null) ...[
                        const SizedBox(height: 16),
                        const Text(
                          'Règles',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(listing.houseRules!),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Erreur: $error')),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BookingScreen(listingId: listingId),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text(AppStrings.bookNow),
          ),
        ),
      ),
    );
  }
  
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }
}

