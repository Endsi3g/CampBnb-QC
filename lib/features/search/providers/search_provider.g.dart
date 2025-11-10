// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_provider.dart';

@riverpod
class SearchFilters extends _$SearchFilters {
  @override
  Map<String, dynamic> build() => {};
}

@riverpod
Future<List<ListingModel>> searchListings(
  SearchListingsRef ref, {
  String? query,
}) async {
  final filters = ref.watch(searchFiltersProvider);
  final supabase = SupabaseService();
  return await supabase.getListings(
    region: filters['region'] as String?,
    city: filters['city'] as String?,
    listingType: filters['listingType'] as String?,
    minPrice: filters['minPrice'] as double?,
    maxPrice: filters['maxPrice'] as double?,
    maxGuests: filters['maxGuests'] as int?,
  );
}

