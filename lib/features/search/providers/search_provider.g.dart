// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$searchListingsHash() => r'926bbc197189bff1362e10d1d05ef957fdb23f52';

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

/// See also [searchListings].
@ProviderFor(searchListings)
const searchListingsProvider = SearchListingsFamily();

/// See also [searchListings].
class SearchListingsFamily extends Family<AsyncValue<List<ListingModel>>> {
  /// See also [searchListings].
  const SearchListingsFamily();

  /// See also [searchListings].
  SearchListingsProvider call({
    String? query,
  }) {
    return SearchListingsProvider(
      query: query,
    );
  }

  @override
  SearchListingsProvider getProviderOverride(
    covariant SearchListingsProvider provider,
  ) {
    return call(
      query: provider.query,
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
  String? get name => r'searchListingsProvider';
}

/// See also [searchListings].
class SearchListingsProvider
    extends AutoDisposeFutureProvider<List<ListingModel>> {
  /// See also [searchListings].
  SearchListingsProvider({
    String? query,
  }) : this._internal(
          (ref) => searchListings(
            ref as SearchListingsRef,
            query: query,
          ),
          from: searchListingsProvider,
          name: r'searchListingsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$searchListingsHash,
          dependencies: SearchListingsFamily._dependencies,
          allTransitiveDependencies:
              SearchListingsFamily._allTransitiveDependencies,
          query: query,
        );

  SearchListingsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.query,
  }) : super.internal();

  final String? query;

  @override
  Override overrideWith(
    FutureOr<List<ListingModel>> Function(SearchListingsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SearchListingsProvider._internal(
        (ref) => create(ref as SearchListingsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        query: query,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<ListingModel>> createElement() {
    return _SearchListingsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SearchListingsProvider && other.query == query;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, query.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SearchListingsRef on AutoDisposeFutureProviderRef<List<ListingModel>> {
  /// The parameter `query` of this provider.
  String? get query;
}

class _SearchListingsProviderElement
    extends AutoDisposeFutureProviderElement<List<ListingModel>>
    with SearchListingsRef {
  _SearchListingsProviderElement(super.provider);

  @override
  String? get query => (origin as SearchListingsProvider).query;
}

String _$searchFiltersHash() => r'729010e58b29d6a2794dbae774d80de4882485a0';

/// See also [SearchFilters].
@ProviderFor(SearchFilters)
final searchFiltersProvider =
    AutoDisposeNotifierProvider<SearchFilters, Map<String, dynamic>>.internal(
  SearchFilters.new,
  name: r'searchFiltersProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$searchFiltersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SearchFilters = AutoDisposeNotifier<Map<String, dynamic>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
