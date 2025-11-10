import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../repositories/booking_repository.dart';
import '../../../repositories/profile_repository.dart';
import '../../../models/booking_model.dart';
import '../../profile/providers/profile_provider.dart';

part 'booking_provider.g.dart';

@riverpod
BookingRepository bookingRepository(BookingRepositoryRef ref) {
  return BookingRepository();
}

@riverpod
Future<List<BookingModel>> userBookings(UserBookingsRef ref) async {
  final repository = ref.watch(bookingRepositoryProvider);
  final profileRepository = ref.watch(profileRepositoryProvider);
  final userId = profileRepository.getCurrentUserId();
  if (userId == null) return [];
  
  return await repository.getUserBookings(userId);
}

@riverpod
class BookingNotifier extends _$BookingNotifier {
  @override
  FutureOr<void> build() {}
  
  Future<String> createBooking(BookingModel booking) async {
    try {
      final repository = ref.read(bookingRepositoryProvider);
      final bookingId = await repository.createBooking(booking);
      return bookingId;
    } catch (e) {
      rethrow;
    }
  }
  
  Future<void> updateBookingStatus(String bookingId, String status) async {
    final repository = ref.read(bookingRepositoryProvider);
    await repository.updateBookingStatus(bookingId, status);
  }
}

