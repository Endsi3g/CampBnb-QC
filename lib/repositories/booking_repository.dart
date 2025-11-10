import '../services/supabase_service.dart';
import '../models/booking_model.dart';
import '../core/utils/logger.dart';

/// Repository pour la gestion des réservations
class BookingRepository {
  final SupabaseService _supabase;

  BookingRepository({SupabaseService? supabase})
      : _supabase = supabase ?? SupabaseService();

  /// Créer une nouvelle réservation
  Future<String> createBooking(BookingModel booking) async {
    try {
      return await _supabase.createBooking(booking);
    } catch (e) {
      errorLogger.e('Erreur repository createBooking: $e');
      rethrow;
    }
  }

  /// Récupérer les réservations d'un utilisateur
  Future<List<BookingModel>> getUserBookings(String userId) async {
    try {
      return await _supabase.getUserBookings(userId);
    } catch (e) {
      errorLogger.e('Erreur repository getUserBookings: $e');
      return [];
    }
  }

  /// Récupérer les réservations d'un listing (pour le host)
  Future<List<BookingModel>> getListingBookings(String listingId) async {
    try {
      // Note: Cette méthode devrait être ajoutée à SupabaseService si nécessaire
      // Pour l'instant, on filtre depuis getUserBookings
      final allBookings = await _supabase.getUserBookings('');
      return allBookings.where((b) => b.listingId == listingId).toList();
    } catch (e) {
      errorLogger.e('Erreur repository getListingBookings: $e');
      return [];
    }
  }

  /// Mettre à jour le statut d'une réservation
  Future<void> updateBookingStatus(String id, String status) async {
    try {
      await _supabase.updateBookingStatus(id, status);
    } catch (e) {
      errorLogger.e('Erreur repository updateBookingStatus: $e');
      rethrow;
    }
  }
}

