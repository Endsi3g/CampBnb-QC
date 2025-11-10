import '../services/supabase_service.dart';
import '../models/listing_model.dart';
import '../core/utils/logger.dart';

/// Repository pour la gestion des listings
class ListingRepository {
  final SupabaseService _supabase;

  ListingRepository({SupabaseService? supabase})
      : _supabase = supabase ?? SupabaseService();

  /// Récupérer tous les listings avec filtres optionnels
  Future<List<ListingModel>> getListings({
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
      return await _supabase.getListings(
        region: region,
        city: city,
        listingType: listingType,
        minPrice: minPrice,
        maxPrice: maxPrice,
        maxGuests: maxGuests,
        limit: limit,
        offset: offset,
      );
    } catch (e) {
      errorLogger.e('Erreur repository getListings: $e');
      rethrow;
    }
  }

  /// Récupérer un listing par ID
  Future<ListingModel?> getListingById(String id) async {
    try {
      return await _supabase.getListing(id);
    } catch (e) {
      errorLogger.e('Erreur repository getListingById: $e');
      return null;
    }
  }

  /// Récupérer les listings d'un utilisateur (host)
  Future<List<ListingModel>> getUserListings(String userId) async {
    try {
      final allListings = await _supabase.getListings();
      return allListings.where((l) => l.hostId == userId).toList();
    } catch (e) {
      errorLogger.e('Erreur repository getUserListings: $e');
      return [];
    }
  }

  /// Créer un nouveau listing
  Future<String> createListing(ListingModel listing) async {
    try {
      return await _supabase.createListing(listing);
    } catch (e) {
      errorLogger.e('Erreur repository createListing: $e');
      rethrow;
    }
  }

  /// Mettre à jour un listing
  Future<void> updateListing(ListingModel listing) async {
    try {
      await _supabase.updateListing(listing);
    } catch (e) {
      errorLogger.e('Erreur repository updateListing: $e');
      rethrow;
    }
  }

  /// Supprimer un listing
  Future<void> deleteListing(String id) async {
    try {
      await _supabase.deleteListing(id);
    } catch (e) {
      errorLogger.e('Erreur repository deleteListing: $e');
      rethrow;
    }
  }
}

