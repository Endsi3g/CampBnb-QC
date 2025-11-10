import '../services/supabase_service.dart';
import '../core/utils/logger.dart';

/// Repository pour la gestion des favoris
class FavoriteRepository {
  final SupabaseService _supabase;

  FavoriteRepository({SupabaseService? supabase})
      : _supabase = supabase ?? SupabaseService();

  /// Ajouter un listing aux favoris
  Future<void> addFavorite(String userId, String listingId) async {
    try {
      await _supabase.addFavorite(userId, listingId);
    } catch (e) {
      errorLogger.e('Erreur repository addFavorite: $e');
      rethrow;
    }
  }

  /// Retirer un listing des favoris
  Future<void> removeFavorite(String userId, String listingId) async {
    try {
      await _supabase.removeFavorite(userId, listingId);
    } catch (e) {
      errorLogger.e('Erreur repository removeFavorite: $e');
      rethrow;
    }
  }

  /// Récupérer la liste des IDs de listings favoris d'un utilisateur
  Future<List<String>> getUserFavorites(String userId) async {
    try {
      return await _supabase.getUserFavorites(userId);
    } catch (e) {
      errorLogger.e('Erreur repository getUserFavorites: $e');
      return [];
    }
  }

  /// Vérifier si un listing est dans les favoris
  Future<bool> isFavorite(String userId, String listingId) async {
    try {
      final favorites = await getUserFavorites(userId);
      return favorites.contains(listingId);
    } catch (e) {
      errorLogger.e('Erreur repository isFavorite: $e');
      return false;
    }
  }
}

