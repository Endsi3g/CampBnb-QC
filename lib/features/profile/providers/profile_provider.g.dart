// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$profileRepositoryHash() => r'8f3a2b1c4d5e6f7a8b9c0d1e2f3a4b5c';
String _$favoriteRepositoryHash() => r'9a4b5c6d7e8f9a0b1c2d3e4f5a6b7c8d';
String _$currentProfileHash() => r'0b1c2d3e4f5a6b7c8d9e0f1a2b3c4d5e';
String _$favoriteListingsHash() => r'1c2d3e4f5a6b7c8d9e0f1a2b3c4d5e6f';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

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

/// See also [currentProfile].
@ProviderFor(currentProfile)
const currentProfileProvider = CurrentProfileFamily();

/// See also [currentProfile].
class CurrentProfileFamily extends Family<AsyncValue<ProfileModel?>> {
  /// See also [currentProfile].
  const CurrentProfileFamily();

  /// See also [currentProfile].
  CurrentProfileProvider call() {
    return CurrentProfileProvider();
  }

  @override
  CurrentProfileProvider getProviderOverride(
    covariant CurrentProfileProvider provider,
  ) {
    return call();
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'currentProfileProvider';
}

/// See also [currentProfile].
class CurrentProfileProvider extends AutoDisposeFutureProvider<ProfileModel?> {
  /// See also [currentProfile].
  CurrentProfileProvider() : this._internal(
          (ref) => currentProfile(
            ref as CurrentProfileRef,
          ),
          from: currentProfileProvider,
          name: r'currentProfileProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$currentProfileHash,
          dependencies: CurrentProfileFamily._dependencies,
          allTransitiveDependencies:
              CurrentProfileFamily._allTransitiveDependencies,
        );

  CurrentProfileProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
  }) : super.internal();

  @override
  FutureOr<ProfileModel?> runNotifierBuild(
    covariant CurrentProfileNotifier notifier,
  ) {
    return notifier.build();
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentProfileRef = AutoDisposeFutureProviderRef<ProfileModel?>;

/// See also [favoriteListings].
@ProviderFor(favoriteListings)
const favoriteListingsProvider = FavoriteListingsFamily();

/// See also [favoriteListings].
class FavoriteListingsFamily extends Family<AsyncValue<List<ListingModel>>> {
  /// See also [favoriteListings].
  const FavoriteListingsFamily();

  /// See also [favoriteListings].
  FavoriteListingsProvider call() {
    return FavoriteListingsProvider();
  }

  @override
  FavoriteListingsProvider getProviderOverride(
    covariant FavoriteListingsProvider provider,
  ) {
    return call();
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'favoriteListingsProvider';
}

/// See also [favoriteListings].
class FavoriteListingsProvider
    extends AutoDisposeFutureProvider<List<ListingModel>> {
  /// See also [favoriteListings].
  FavoriteListingsProvider() : this._internal(
          (ref) => favoriteListings(
            ref as FavoriteListingsRef,
          ),
          from: favoriteListingsProvider,
          name: r'favoriteListingsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$favoriteListingsHash,
          dependencies: FavoriteListingsFamily._dependencies,
          allTransitiveDependencies:
              FavoriteListingsFamily._allTransitiveDependencies,
        );

  FavoriteListingsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
  }) : super.internal();

  @override
  FutureOr<List<ListingModel>> runNotifierBuild(
    covariant FavoriteListingsNotifier notifier,
  ) {
    return notifier.build();
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FavoriteListingsRef = AutoDisposeFutureProviderRef<List<ListingModel>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

