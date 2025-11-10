import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../services/supabase_service.dart';
import '../../../models/booking_model.dart';

part 'booking_provider.g.dart';

@riverpod
Future<List<BookingModel>> userBookings(UserBookingsRef ref) async {
  final supabase = SupabaseService();
  final user = supabase.currentUser;
  if (user == null) return [];
  
  return await supabase.getUserBookings(user.id);
}

@riverpod
class BookingNotifier extends _$BookingNotifier {
  final _supabase = SupabaseService();
  
  @override
  FutureOr<void> build() {}
  
  Future<String> createBooking(BookingModel booking) async {
    try {
      final bookingId = await _supabase.createBooking(booking);
      return bookingId;
    } catch (e) {
      rethrow;
    }
  }
  
  Future<void> updateBookingStatus(String bookingId, String status) async {
    await _supabase.updateBookingStatus(bookingId, status);
  }
}

