import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../repositories/listing_repository.dart';
import '../../../repositories/profile_repository.dart';
import '../../../models/listing_model.dart';
import '../../profile/providers/profile_provider.dart';

part 'listing_provider.g.dart';

@riverpod
ListingRepository listingRepository(ListingRepositoryRef ref) {
  return ListingRepository();
}

@riverpod
Future<ListingModel?> listingDetails(ListingDetailsRef ref, String listingId) async {
  final repository = ref.watch(listingRepositoryProvider);
  return await repository.getListingById(listingId);
}

@riverpod
Future<List<ListingModel>> userListings(UserListingsRef ref) async {
  final repository = ref.watch(listingRepositoryProvider);
  final profileRepository = ref.watch(profileRepositoryProvider);
  final userId = profileRepository.getCurrentUserId();
  if (userId == null) return [];
  
  return await repository.getUserListings(userId);
}

