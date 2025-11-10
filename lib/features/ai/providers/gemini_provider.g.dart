// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gemini_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$aiRecommendationsHash() => r'afd1e5095df1664add56240d06a97548890272b7';

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

/// See also [aiRecommendations].
@ProviderFor(aiRecommendations)
const aiRecommendationsProvider = AiRecommendationsFamily();

/// See also [aiRecommendations].
class AiRecommendationsFamily
    extends Family<AsyncValue<List<Map<String, dynamic>>>> {
  /// See also [aiRecommendations].
  const AiRecommendationsFamily();

  /// See also [aiRecommendations].
  AiRecommendationsProvider call({
    String? region,
    String? preferredType,
    int? budget,
    List<String>? preferredAmenities,
  }) {
    return AiRecommendationsProvider(
      region: region,
      preferredType: preferredType,
      budget: budget,
      preferredAmenities: preferredAmenities,
    );
  }

  @override
  AiRecommendationsProvider getProviderOverride(
    covariant AiRecommendationsProvider provider,
  ) {
    return call(
      region: provider.region,
      preferredType: provider.preferredType,
      budget: provider.budget,
      preferredAmenities: provider.preferredAmenities,
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
  String? get name => r'aiRecommendationsProvider';
}

/// See also [aiRecommendations].
class AiRecommendationsProvider
    extends AutoDisposeFutureProvider<List<Map<String, dynamic>>> {
  /// See also [aiRecommendations].
  AiRecommendationsProvider({
    String? region,
    String? preferredType,
    int? budget,
    List<String>? preferredAmenities,
  }) : this._internal(
          (ref) => aiRecommendations(
            ref as AiRecommendationsRef,
            region: region,
            preferredType: preferredType,
            budget: budget,
            preferredAmenities: preferredAmenities,
          ),
          from: aiRecommendationsProvider,
          name: r'aiRecommendationsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$aiRecommendationsHash,
          dependencies: AiRecommendationsFamily._dependencies,
          allTransitiveDependencies:
              AiRecommendationsFamily._allTransitiveDependencies,
          region: region,
          preferredType: preferredType,
          budget: budget,
          preferredAmenities: preferredAmenities,
        );

  AiRecommendationsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.region,
    required this.preferredType,
    required this.budget,
    required this.preferredAmenities,
  }) : super.internal();

  final String? region;
  final String? preferredType;
  final int? budget;
  final List<String>? preferredAmenities;

  @override
  Override overrideWith(
    FutureOr<List<Map<String, dynamic>>> Function(AiRecommendationsRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AiRecommendationsProvider._internal(
        (ref) => create(ref as AiRecommendationsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        region: region,
        preferredType: preferredType,
        budget: budget,
        preferredAmenities: preferredAmenities,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Map<String, dynamic>>> createElement() {
    return _AiRecommendationsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AiRecommendationsProvider &&
        other.region == region &&
        other.preferredType == preferredType &&
        other.budget == budget &&
        other.preferredAmenities == preferredAmenities;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, region.hashCode);
    hash = _SystemHash.combine(hash, preferredType.hashCode);
    hash = _SystemHash.combine(hash, budget.hashCode);
    hash = _SystemHash.combine(hash, preferredAmenities.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AiRecommendationsRef
    on AutoDisposeFutureProviderRef<List<Map<String, dynamic>>> {
  /// The parameter `region` of this provider.
  String? get region;

  /// The parameter `preferredType` of this provider.
  String? get preferredType;

  /// The parameter `budget` of this provider.
  int? get budget;

  /// The parameter `preferredAmenities` of this provider.
  List<String>? get preferredAmenities;
}

class _AiRecommendationsProviderElement
    extends AutoDisposeFutureProviderElement<List<Map<String, dynamic>>>
    with AiRecommendationsRef {
  _AiRecommendationsProviderElement(super.provider);

  @override
  String? get region => (origin as AiRecommendationsProvider).region;
  @override
  String? get preferredType =>
      (origin as AiRecommendationsProvider).preferredType;
  @override
  int? get budget => (origin as AiRecommendationsProvider).budget;
  @override
  List<String>? get preferredAmenities =>
      (origin as AiRecommendationsProvider).preferredAmenities;
}

String _$geminiChatHash() => r'd126dfb25a9266d8d5f61142cc77aa27a02a554b';

/// See also [GeminiChat].
@ProviderFor(GeminiChat)
final geminiChatProvider =
    AutoDisposeNotifierProvider<GeminiChat, List<Map<String, String>>>.internal(
  GeminiChat.new,
  name: r'geminiChatProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$geminiChatHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$GeminiChat = AutoDisposeNotifier<List<Map<String, String>>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
