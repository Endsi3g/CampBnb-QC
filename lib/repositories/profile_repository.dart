import '../services/supabase_service.dart';
import '../models/profile_model.dart';
import '../core/utils/logger.dart';

/// Repository pour la gestion des profils utilisateur
class ProfileRepository {
  final SupabaseService _supabase;

  ProfileRepository({SupabaseService? supabase})
      : _supabase = supabase ?? SupabaseService();

  /// Récupérer le profil d'un utilisateur
  Future<ProfileModel?> getProfile(String userId) async {
    try {
      return await _supabase.getProfile(userId);
    } catch (e) {
      errorLogger.e('Erreur repository getProfile: $e');
      return null;
    }
  }

  /// Mettre à jour le profil d'un utilisateur
  Future<void> updateProfile(ProfileModel profile) async {
    try {
      await _supabase.updateProfile(profile);
    } catch (e) {
      errorLogger.e('Erreur repository updateProfile: $e');
      rethrow;
    }
  }

  /// Récupérer l'utilisateur actuel
  String? getCurrentUserId() {
    return _supabase.currentUser?.id;
  }
}

