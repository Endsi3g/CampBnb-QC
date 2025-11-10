// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_provider.dart';

@riverpod
Future<List<BookingModel>> userBookings(UserBookingsRef ref) async {
  final supabase = SupabaseService();
  final user = supabase.currentUser;
  if (user == null) return [];
  return await supabase.getUserBookings(user.id);
}

@riverpod
class BookingNotifier extends _$BookingNotifier {
  @override
  FutureOr<void> build() {}
}

