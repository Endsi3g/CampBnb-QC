import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../repositories/profile_repository.dart';
import '../../../repositories/favorite_repository.dart';
import '../../../repositories/listing_repository.dart';
import '../../../models/profile_model.dart';
import '../../../models/listing_model.dart';

part 'profile_provider.g.dart';

@riverpod
ProfileRepository profileRepository(ProfileRepositoryRef ref) {
  return ProfileRepository();
}

@riverpod
FavoriteRepository favoriteRepository(FavoriteRepositoryRef ref) {
  return FavoriteRepository();
}

@riverpod
Future<ProfileModel?> currentProfile(CurrentProfileRef ref) async {
  final repository = ref.watch(profileRepositoryProvider);
  final userId = repository.getCurrentUserId();
  if (userId == null) return null;
  
  return await repository.getProfile(userId);
}

@riverpod
Future<List<ListingModel>> favoriteListings(FavoriteListingsRef ref) async {
  final profileRepository = ref.watch(profileRepositoryProvider);
  final favoriteRepository = ref.watch(favoriteRepositoryProvider);
  final listingRepository = ref.watch(listingRepositoryProvider);
  
  final userId = profileRepository.getCurrentUserId();
  if (userId == null) return [];
  
  final favoriteIds = await favoriteRepository.getUserFavorites(userId);
  if (favoriteIds.isEmpty) return [];
  
  // Récupérer les listings correspondants
  final allListings = await listingRepository.getListings();
  return allListings.where((listing) => favoriteIds.contains(listing.id)).toList();
}

