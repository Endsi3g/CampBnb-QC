import 'package:supabase_flutter/supabase_flutter.dart';
import '../core/utils/logger.dart';
import '../models/profile_model.dart';
import '../models/listing_model.dart';
import '../models/booking_model.dart';
import 'mock_data_service.dart';

/// Service Supabase mock pour le mode sandbox
class MockSupabaseService {
  static final MockSupabaseService _instance = MockSupabaseService._internal();
  factory MockSupabaseService() => _instance;
  MockSupabaseService._internal();
  
  final MockDataService _mockData = MockDataService();
  bool _initialized = false;
  String? _currentUserId;
  final Map<String, ProfileModel> _profiles = {};
  final Map<String, ListingModel> _listings = {};
  final Map<String, BookingModel> _bookings = {};
  final Map<String, List<String>> _favorites = {};
  
  /// Initialiser le service mock
  Future<void> initialize() async {
    if (_initialized) return;
    
    // Charger les données mock
    final listings = _mockData.getMockListings();
    for (final listing in listings) {
      _listings[listing.id] = listing;
    }
    
    _initialized = true;
    appLogger.i('Mock Supabase initialisé (mode sandbox)');
  }
  
  SupabaseClient get client {
    throw UnsupportedError('Utilisez les méthodes mock directement');
  }
  
  User? get currentUser {
    if (_currentUserId == null) return null;
    return User(
      id: _currentUserId!,
      appMetadata: {},
      userMetadata: {},
      aud: 'authenticated',
      createdAt: DateTime.now().toIso8601String(),
    );
  }
  
  // ============================================
  // AUTHENTIFICATION
  // ============================================
  
  Future<AuthResponse> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500)); // Simuler latence
    
    _currentUserId = 'mock_user_${DateTime.now().millisecondsSinceEpoch}';
    final profile = _mockData.getMockProfile(_currentUserId!);
    profile.email = email;
    _profiles[_currentUserId!] = profile;
    _favorites[_currentUserId!] = [];
    
    appLogger.i('Inscription mock réussie: $email');
    
    return AuthResponse(
      user: currentUser!,
      session: null,
    );
  }
  
  Future<AuthResponse> signInWithEmail({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Créer un utilisateur mock s'il n'existe pas
    if (_currentUserId == null) {
      _currentUserId = 'mock_user_${email.hashCode}';
      final profile = _mockData.getMockProfile(_currentUserId!);
      profile.email = email;
      _profiles[_currentUserId!] = profile;
      _favorites[_currentUserId!] = _mockData.getMockFavorites(_currentUserId!);
    }
    
    appLogger.i('Connexion mock réussie: $email');
    
    return AuthResponse(
      user: currentUser!,
      session: null,
    );
  }
  
  Future<void> signOut() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _currentUserId = null;
    appLogger.i('Déconnexion mock réussie');
  }
  
  // ============================================
  // PROFILES
  // ============================================
  
  Future<ProfileModel?> getProfile(String userId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _profiles[userId] ?? _mockData.getMockProfile(userId);
  }
  
  Future<void> updateProfile(ProfileModel profile) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _profiles[profile.id] = profile;
    appLogger.i('Profil mock mis à jour: ${profile.id}');
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
    await Future.delayed(const Duration(milliseconds: 500));
    
    var listings = _listings.values.toList();
    
    if (region != null) {
      listings = listings.where((l) => l.region == region).toList();
    }
    if (city != null) {
      listings = listings.where((l) => l.city == city).toList();
    }
    if (listingType != null) {
      listings = listings.where((l) => l.listingType == listingType).toList();
    }
    if (minPrice != null) {
      listings = listings.where((l) => l.pricePerNight >= minPrice).toList();
    }
    if (maxPrice != null) {
      listings = listings.where((l) => l.pricePerNight <= maxPrice).toList();
    }
    if (maxGuests != null) {
      listings = listings.where((l) => l.maxGuests >= maxGuests).toList();
    }
    
    // Trier par date de création
    listings.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    
    // Pagination
    final end = (offset + limit).clamp(0, listings.length);
    return listings.sublist(offset.clamp(0, listings.length), end);
  }
  
  Future<ListingModel?> getListing(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _listings[id];
  }
  
  Future<String> createListing(ListingModel listing) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final newId = 'mock_listing_${DateTime.now().millisecondsSinceEpoch}';
    final newListing = listing.copyWith(id: newId);
    _listings[newId] = newListing;
    appLogger.i('Listing mock créé: $newId');
    return newId;
  }
  
  Future<void> updateListing(ListingModel listing) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _listings[listing.id] = listing;
    appLogger.i('Listing mock mis à jour: ${listing.id}');
  }
  
  Future<void> deleteListing(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _listings.remove(id);
    appLogger.i('Listing mock supprimé: $id');
  }
  
  // ============================================
  // BOOKINGS
  // ============================================
  
  Future<String> createBooking(BookingModel booking) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final newId = 'mock_booking_${DateTime.now().millisecondsSinceEpoch}';
    final newBooking = booking.copyWith(id: newId);
    _bookings[newId] = newBooking;
    appLogger.i('Réservation mock créée: $newId');
    return newId;
  }
  
  Future<List<BookingModel>> getUserBookings(String userId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final bookings = _bookings.values
        .where((b) => b.guestId == userId)
        .toList();
    
    // Si pas de réservations, retourner les mock
    if (bookings.isEmpty && _currentUserId == userId) {
      return _mockData.getMockBookings(userId);
    }
    
    bookings.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return bookings;
  }
  
  Future<void> updateBookingStatus(String id, String status) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final booking = _bookings[id];
    if (booking != null) {
      _bookings[id] = booking.copyWith(status: status);
      appLogger.i('Statut réservation mock mis à jour: $id -> $status');
    }
  }
  
  // ============================================
  // FAVORITES
  // ============================================
  
  Future<void> addFavorite(String userId, String listingId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _favorites.putIfAbsent(userId, () => []).add(listingId);
    appLogger.i('Favori mock ajouté: $listingId');
  }
  
  Future<void> removeFavorite(String userId, String listingId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _favorites[userId]?.remove(listingId);
    appLogger.i('Favori mock supprimé: $listingId');
  }
  
  Future<List<String>> getUserFavorites(String userId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _favorites[userId] ?? _mockData.getMockFavorites(userId);
  }
  
  // ============================================
  // STORAGE (Images)
  // ============================================
  
  Future<String> uploadImage(String path, List<int> bytes) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    // Retourner une URL mock
    return 'https://via.placeholder.com/800x600?text=Mock+Image';
  }
  
  Future<void> deleteImage(String path) async {
    await Future.delayed(const Duration(milliseconds: 300));
    appLogger.i('Image mock supprimée: $path');
  }
}

