import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../services/supabase_service.dart';
import '../../../models/listing_model.dart';

part 'listing_provider.g.dart';

@riverpod
Future<ListingModel?> listingDetails(ListingDetailsRef ref, String listingId) async {
  final supabase = SupabaseService();
  return await supabase.getListing(listingId);
}

@riverpod
Future<List<ListingModel>> userListings(UserListingsRef ref) async {
  final supabase = SupabaseService();
  final user = supabase.currentUser;
  if (user == null) return [];
  
  // Note: Implémenter une méthode spécifique pour les listings de l'utilisateur
  final allListings = await supabase.getListings();
  return allListings.where((l) => l.hostId == user.id).toList();
}

