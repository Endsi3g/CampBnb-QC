import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_constants.dart';
import '../../../shared/widgets/listing_card.dart';
import '../providers/search_provider.dart';
import '../../listing/screens/listing_detail_screen.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});
  
  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _searchController = TextEditingController();
  String? _selectedRegion;
  String? _selectedType;
  double? _minPrice;
  double? _maxPrice;
  
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
  
  void _applyFilters() {
    ref.read(searchFiltersProvider.notifier).updateFilters({
      if (_selectedRegion != null) 'region': _selectedRegion,
      if (_selectedType != null) 'listingType': _selectedType,
      if (_minPrice != null) 'minPrice': _minPrice,
      if (_maxPrice != null) 'maxPrice': _maxPrice,
    });
  }
  
  @override
  Widget build(BuildContext context) {
    final listingsAsync = ref.watch(searchListingsProvider());
    
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.search),
      ),
      body: Column(
        children: [
          // Barre de recherche et filtres
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: AppStrings.searchPlaceholder,
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Filtres rapides
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _selectedRegion,
                        decoration: const InputDecoration(
                          labelText: 'Région',
                          border: OutlineInputBorder(),
                        ),
                        items: AppConstants.quebecRegions
                            .map((r) => DropdownMenuItem(value: r, child: Text(r)))
                            .toList(),
                        onChanged: (value) {
                          setState(() => _selectedRegion = value);
                          _applyFilters();
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _selectedType,
                        decoration: const InputDecoration(
                          labelText: 'Type',
                          border: OutlineInputBorder(),
                        ),
                        items: AppConstants.listingTypes
                            .map((t) => DropdownMenuItem(
                                  value: t,
                                  child: Text(t),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() => _selectedType = value);
                          _applyFilters();
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: _applyFilters,
                  child: const Text('Appliquer les filtres'),
                ),
              ],
            ),
          ),
          // Résultats
          Expanded(
            child: listingsAsync.when(
              data: (listings) {
                if (listings.isEmpty) {
                  return Center(
                    child: Text(
                      AppStrings.noResults,
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  );
                }
                
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
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
          ),
        ],
      ),
    );
  }
}

