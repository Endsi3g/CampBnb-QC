// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gemini_provider.dart';

@riverpod
class GeminiChat extends _$GeminiChat {
  @override
  List<Map<String, String>> build() => [];
}

@riverpod
Future<List<Map<String, dynamic>>> aiRecommendations(
  AiRecommendationsRef ref, {
  String? region,
  String? preferredType,
  int? budget,
  List<String>? preferredAmenities,
}) async {
  final gemini = GeminiService();
  final supabase = SupabaseService();
  final user = supabase.currentUser;
  if (user == null) return [];
  final history = await supabase.getUserBookings(user.id);
  return await gemini.getRecommendations(
    userId: user.id,
    region: region,
    preferredType: preferredType,
    budget: budget,
    preferredAmenities: preferredAmenities,
    userHistory: {
      'total_bookings': history.length,
      'preferred_regions': history.map((b) => b.listingId).toList(),
    },
  );
}

