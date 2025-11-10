import 'dart:typed_data';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../core/config/env_config.dart';
import '../core/utils/logger.dart';
import '../models/profile_model.dart';
import '../models/listing_model.dart';
import '../models/booking_model.dart';

/// Service Supabase pour toutes les opérations backend
class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();
  factory SupabaseService() => _instance;
  SupabaseService._internal();
  
  late SupabaseClient _client;
  bool _initialized = false;
  
  /// Initialiser Supabase
  Future<void> initialize() async {
    if (_initialized) return;
    
    try {
      await Supabase.initialize(
        url: EnvConfig.supabaseUrl,
        anonKey: EnvConfig.supabaseAnonKey,
      );
      _client = Supabase.instance.client;
      _initialized = true;
      appLogger.i('Supabase initialisé avec succès');
    } catch (e) {
      errorLogger.e('Erreur initialisation Supabase: $e');
      rethrow;
    }
  }
  
  SupabaseClient get client {
    if (!_initialized) {
      throw Exception('Supabase non initialisé. Appelez initialize() d\'abord.');
    }
    return _client;
  }
  
  User? get currentUser => _client.auth.currentUser;
  
  // ============================================
  // AUTHENTIFICATION
  // ============================================
  
  Future<AuthResponse> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _client.auth.signUp(
        email: email,
        password: password,
      );
      return response;
    } catch (e) {
      errorLogger.e('Erreur inscription: $e');
      rethrow;
    }
  }
  
  Future<AuthResponse> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return response;
    } catch (e) {
      errorLogger.e('Erreur connexion: $e');
      rethrow;
    }
  }
  
  Future<void> signOut() async {
    try {
      await _client.auth.signOut();
    } catch (e) {
      errorLogger.e('Erreur déconnexion: $e');
      rethrow;
    }
  }
  
  // ============================================
  // PROFILES
  // ============================================
  
  Future<ProfileModel?> getProfile(String userId) async {
    try {
      final response = await _client
          .from('profiles')
          .select()
          .eq('id', userId)
          .single();
      
      return ProfileModel.fromJson(response);
    } catch (e) {
      errorLogger.e('Erreur récupération profil: $e');
      return null;
    }
  }
  
  Future<void> updateProfile(ProfileModel profile) async {
    try {
      await _client
          .from('profiles')
          .update(profile.toJson())
          .eq('id', profile.id);
    } catch (e) {
      errorLogger.e('Erreur mise à jour profil: $e');
      rethrow;
    }
  }
  
  // ============================================
  // LISTINGS
  // ============================================
  
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
      var query = _client
          .from('listings')
          .select()
          .eq('status', 'active');
      
      if (region != null) {
        query = query.eq('region', region);
      }
      if (city != null) {
        query = query.eq('city', city);
      }
      if (listingType != null) {
        query = query.eq('listing_type', listingType);
      }
      if (minPrice != null) {
        query = query.gte('price_per_night', minPrice);
      }
      if (maxPrice != null) {
        query = query.lte('price_per_night', maxPrice);
      }
      if (maxGuests != null) {
        query = query.gte('max_guests', maxGuests);
      }
      
      final finalQuery = query
          .order('created_at', ascending: false)
          .range(offset, offset + limit - 1);
      
      final response = await finalQuery;
      return (response as List)
          .map((json) => ListingModel.fromJson(json))
          .toList();
    } catch (e) {
      errorLogger.e('Erreur récupération listings: $e');
      return [];
    }
  }
  
  Future<ListingModel?> getListing(String id) async {
    try {
      final response = await _client
          .from('listings')
          .select()
          .eq('id', id)
          .single();
      
      return ListingModel.fromJson(response);
    } catch (e) {
      errorLogger.e('Erreur récupération listing: $e');
      return null;
    }
  }
  
  Future<String> createListing(ListingModel listing) async {
    try {
      final response = await _client
          .from('listings')
          .insert(listing.toJson())
          .select()
          .single();
      
      return response['id'] as String;
    } catch (e) {
      errorLogger.e('Erreur création listing: $e');
      rethrow;
    }
  }
  
  Future<void> updateListing(ListingModel listing) async {
    try {
      await _client
          .from('listings')
          .update(listing.toJson())
          .eq('id', listing.id);
    } catch (e) {
      errorLogger.e('Erreur mise à jour listing: $e');
      rethrow;
    }
  }
  
  Future<void> deleteListing(String id) async {
    try {
      await _client
          .from('listings')
          .delete()
          .eq('id', id);
    } catch (e) {
      errorLogger.e('Erreur suppression listing: $e');
      rethrow;
    }
  }
  
  // ============================================
  // BOOKINGS
  // ============================================
  
  Future<String> createBooking(BookingModel booking) async {
    try {
      final response = await _client
          .from('bookings')
          .insert(booking.toJson())
          .select()
          .single();
      
      return response['id'] as String;
    } catch (e) {
      errorLogger.e('Erreur création réservation: $e');
      rethrow;
    }
  }
  
  Future<List<BookingModel>> getUserBookings(String userId) async {
    try {
      final response = await _client
          .from('bookings')
          .select()
          .eq('guest_id', userId)
          .order('created_at', ascending: false);
      
      return (response as List)
          .map((json) => BookingModel.fromJson(json))
          .toList();
    } catch (e) {
      errorLogger.e('Erreur récupération réservations: $e');
      return [];
    }
  }
  
  Future<void> updateBookingStatus(String id, String status) async {
    try {
      await _client
          .from('bookings')
          .update({'status': status})
          .eq('id', id);
    } catch (e) {
      errorLogger.e('Erreur mise à jour réservation: $e');
      rethrow;
    }
  }
  
  // ============================================
  // FAVORITES
  // ============================================
  
  Future<void> addFavorite(String userId, String listingId) async {
    try {
      await _client
          .from('favorites')
          .insert({
            'user_id': userId,
            'listing_id': listingId,
          });
    } catch (e) {
      errorLogger.e('Erreur ajout favori: $e');
      rethrow;
    }
  }
  
  Future<void> removeFavorite(String userId, String listingId) async {
    try {
      await _client
          .from('favorites')
          .delete()
          .eq('user_id', userId)
          .eq('listing_id', listingId);
    } catch (e) {
      errorLogger.e('Erreur suppression favori: $e');
      rethrow;
    }
  }
  
  Future<List<String>> getUserFavorites(String userId) async {
    try {
      final response = await _client
          .from('favorites')
          .select('listing_id')
          .eq('user_id', userId);
      
      return (response as List)
          .map((item) => item['listing_id'] as String)
          .toList();
    } catch (e) {
      errorLogger.e('Erreur récupération favoris: $e');
      return [];
    }
  }
  
  // ============================================
  // STORAGE (Images)
  // ============================================
  
  Future<String> uploadImage(String path, Uint8List bytes) async {
    try {
      final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      await _client.storage
          .from('listing-photos')
          .uploadBinary(fileName, bytes);
      
      final url = _client.storage
          .from('listing-photos')
          .getPublicUrl(fileName);
      
      return url;
    } catch (e) {
      errorLogger.e('Erreur upload image: $e');
      rethrow;
    }
  }
  
  Future<void> deleteImage(String path) async {
    try {
      await _client.storage
          .from('listing-photos')
          .remove([path]);
    } catch (e) {
      errorLogger.e('Erreur suppression image: $e');
      rethrow;
    }
  }
}

