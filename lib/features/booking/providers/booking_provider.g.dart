// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$bookingRepositoryHash() => r'adc6f172d41b0be40f482f41c61ef6f9dee83829';

/// See also [bookingRepository].
@ProviderFor(bookingRepository)
final bookingRepositoryProvider =
    AutoDisposeProvider<BookingRepository>.internal(
  bookingRepository,
  name: r'bookingRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$bookingRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef BookingRepositoryRef = AutoDisposeProviderRef<BookingRepository>;
String _$userBookingsHash() => r'31573e78c5b25bc974153b6c845eaa218f36d561';

/// See also [userBookings].
@ProviderFor(userBookings)
final userBookingsProvider =
    AutoDisposeFutureProvider<List<BookingModel>>.internal(
  userBookings,
  name: r'userBookingsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userBookingsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UserBookingsRef = AutoDisposeFutureProviderRef<List<BookingModel>>;
String _$bookingNotifierHash() => r'97dfe391930737fbc0477debdd1c4db2ec65d9a9';

/// See also [BookingNotifier].
@ProviderFor(BookingNotifier)
final bookingNotifierProvider =
    AutoDisposeAsyncNotifierProvider<BookingNotifier, void>.internal(
  BookingNotifier.new,
  name: r'bookingNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$bookingNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$BookingNotifier = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
