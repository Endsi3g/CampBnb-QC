import '../repositories/listing_repository.dart';
import '../models/listing_model.dart';

/// Repository pour la recherche de listings
class SearchRepository {
  final ListingRepository _listingRepository;

  SearchRepository({ListingRepository? listingRepository})
      : _listingRepository = listingRepository ?? ListingRepository();

  /// Rechercher des listings avec filtres
  Future<List<ListingModel>> searchListings({
    String? query,
    String? region,
    String? city,
    String? listingType,
    double? minPrice,
    double? maxPrice,
    int? maxGuests,
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      var listings = await _listingRepository.getListings(
        region: region,
        city: city,
        listingType: listingType,
        minPrice: minPrice,
        maxPrice: maxPrice,
        maxGuests: maxGuests,
        limit: limit,
        offset: offset,
      );

      // Si une requête textuelle est fournie, filtrer par titre/description
      if (query != null && query.isNotEmpty) {
        final queryLower = query.toLowerCase();
        listings = listings.where((listing) {
          return listing.title.toLowerCase().contains(queryLower) ||
              listing.description.toLowerCase().contains(queryLower) ||
              listing.city.toLowerCase().contains(queryLower) ||
              listing.region.toLowerCase().contains(queryLower);
        }).toList();
      }

      return listings;
    } catch (e) {
      rethrow;
    }
  }
}

