// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$profileRepositoryHash() => r'a418040ab411f107fba532de8de16ac2d7b772cf';

/// See also [profileRepository].
@ProviderFor(profileRepository)
final profileRepositoryProvider =
    AutoDisposeProvider<ProfileRepository>.internal(
  profileRepository,
  name: r'profileRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$profileRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ProfileRepositoryRef = AutoDisposeProviderRef<ProfileRepository>;
String _$favoriteRepositoryHash() =>
    r'4db8ff3394d8f2a3e23519de3cb7972abf3044aa';

/// See also [favoriteRepository].
@ProviderFor(favoriteRepository)
final favoriteRepositoryProvider =
    AutoDisposeProvider<FavoriteRepository>.internal(
  favoriteRepository,
  name: r'favoriteRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$favoriteRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FavoriteRepositoryRef = AutoDisposeProviderRef<FavoriteRepository>;
String _$currentProfileHash() => r'b1aaf22dfa897d9e16f2aa0456008f33107c1953';

/// See also [currentProfile].
@ProviderFor(currentProfile)
final currentProfileProvider =
    AutoDisposeFutureProvider<ProfileModel?>.internal(
  currentProfile,
  name: r'currentProfileProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentProfileHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentProfileRef = AutoDisposeFutureProviderRef<ProfileModel?>;
String _$favoriteListingsHash() => r'38216a8501917e0bad528cacd6011091f5639820';

/// See also [favoriteListings].
@ProviderFor(favoriteListings)
final favoriteListingsProvider =
    AutoDisposeFutureProvider<List<ListingModel>>.internal(
  favoriteListings,
  name: r'favoriteListingsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$favoriteListingsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FavoriteListingsRef = AutoDisposeFutureProviderRef<List<ListingModel>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
