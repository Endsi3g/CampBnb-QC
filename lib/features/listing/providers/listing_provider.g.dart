// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listing_provider.dart';

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
  final allListings = await supabase.getListings();
  return allListings.where((l) => l.hostId == user.id).toList();
}

