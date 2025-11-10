// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_provider.dart';

typedef AuthNotifierRef = AutoDisposeAsyncNotifierProviderRef<ProfileModel?>;

@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  Future<ProfileModel?> build() async {
    final _supabase = SupabaseService();
    final user = _supabase.currentUser;
    if (user == null) return null;
    return await _supabase.getProfile(user.id);
  }
}

