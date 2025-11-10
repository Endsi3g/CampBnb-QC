import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../services/supabase_service.dart';
import '../../../models/profile_model.dart';

part 'auth_provider.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  final _supabase = SupabaseService();
  
  @override
  Future<ProfileModel?> build() async {
    final user = _supabase.currentUser;
    if (user == null) return null;
    
    return await _supabase.getProfile(user.id);
  }
  
  Future<void> signInWithEmail(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      await _supabase.signInWithEmail(email: email, password: password);
      final user = _supabase.currentUser;
      if (user != null) {
        final profile = await _supabase.getProfile(user.id);
        state = AsyncValue.data(profile);
      }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      rethrow;
    }
  }
  
  Future<void> signUpWithEmail(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      await _supabase.signUpWithEmail(email: email, password: password);
      final user = _supabase.currentUser;
      if (user != null) {
        final profile = await _supabase.getProfile(user.id);
        state = AsyncValue.data(profile);
      }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      rethrow;
    }
  }
  
  Future<void> signOut() async {
    await _supabase.signOut();
    state = const AsyncValue.data(null);
  }
}

