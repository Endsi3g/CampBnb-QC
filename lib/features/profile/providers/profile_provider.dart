import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../repositories/profile_repository.dart';
import '../../../models/profile_model.dart';

part 'profile_provider.g.dart';

@riverpod
ProfileRepository profileRepository(ProfileRepositoryRef ref) {
  return ProfileRepository();
}

@riverpod
Future<ProfileModel?> currentProfile(CurrentProfileRef ref) async {
  final repository = ref.watch(profileRepositoryProvider);
  final userId = repository.getCurrentUserId();
  if (userId == null) return null;
  
  return await repository.getProfile(userId);
}

