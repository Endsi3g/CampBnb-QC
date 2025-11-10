import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../services/gemini_service.dart';

part 'gemini_provider.g.dart';

@riverpod
class GeminiChat extends _$GeminiChat {
  final _gemini = GeminiService();
  final List<Map<String, String>> _history = [];
  
  @override
  List<Map<String, String>> build() => _history;
  
  Future<String> sendMessage(String message, {String? context}) async {
    try {
      final response = await _gemini.chat(
        message: message,
        conversationHistory: _history,
        context: context,
      );
      
      _history.add({'role': 'user', 'content': message});
      _history.add({'role': 'assistant', 'content': response});
      
      state = List.from(_history);
      return response;
    } catch (e) {
      rethrow;
    }
  }
  
  void clearHistory() {
    _history.clear();
    state = [];
  }
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

