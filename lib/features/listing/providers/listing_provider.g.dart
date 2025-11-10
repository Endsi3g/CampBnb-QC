// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listing_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$listingDetailsHash() => r'147da1976431cab2595ef3b2f4b6987341a0b8b0';

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

/// See also [listingDetails].
@ProviderFor(listingDetails)
const listingDetailsProvider = ListingDetailsFamily();

/// See also [listingDetails].
class ListingDetailsFamily extends Family<AsyncValue<ListingModel?>> {
  /// See also [listingDetails].
  const ListingDetailsFamily();

  /// See also [listingDetails].
  ListingDetailsProvider call(
    String listingId,
  ) {
    return ListingDetailsProvider(
      listingId,
    );
  }

  @override
  ListingDetailsProvider getProviderOverride(
    covariant ListingDetailsProvider provider,
  ) {
    return call(
      provider.listingId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'listingDetailsProvider';
}

/// See also [listingDetails].
class ListingDetailsProvider extends AutoDisposeFutureProvider<ListingModel?> {
  /// See also [listingDetails].
  ListingDetailsProvider(
    String listingId,
  ) : this._internal(
          (ref) => listingDetails(
            ref as ListingDetailsRef,
            listingId,
          ),
          from: listingDetailsProvider,
          name: r'listingDetailsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$listingDetailsHash,
          dependencies: ListingDetailsFamily._dependencies,
          allTransitiveDependencies:
              ListingDetailsFamily._allTransitiveDependencies,
          listingId: listingId,
        );

  ListingDetailsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.listingId,
  }) : super.internal();

  final String listingId;

  @override
  Override overrideWith(
    FutureOr<ListingModel?> Function(ListingDetailsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ListingDetailsProvider._internal(
        (ref) => create(ref as ListingDetailsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        listingId: listingId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<ListingModel?> createElement() {
    return _ListingDetailsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ListingDetailsProvider && other.listingId == listingId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, listingId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ListingDetailsRef on AutoDisposeFutureProviderRef<ListingModel?> {
  /// The parameter `listingId` of this provider.
  String get listingId;
}

class _ListingDetailsProviderElement
    extends AutoDisposeFutureProviderElement<ListingModel?>
    with ListingDetailsRef {
  _ListingDetailsProviderElement(super.provider);

  @override
  String get listingId => (origin as ListingDetailsProvider).listingId;
}

String _$userListingsHash() => r'357286d45691125f0b5f397ed59fda78a9cbc85b';

/// See also [userListings].
@ProviderFor(userListings)
final userListingsProvider =
    AutoDisposeFutureProvider<List<ListingModel>>.internal(
  userListings,
  name: r'userListingsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userListingsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UserListingsRef = AutoDisposeFutureProviderRef<List<ListingModel>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
