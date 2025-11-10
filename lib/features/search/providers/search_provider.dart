import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../services/supabase_service.dart';
import '../../../models/listing_model.dart';

part 'search_provider.g.dart';

@riverpod
class SearchFilters extends _$SearchFilters {
  @override
  Map<String, dynamic> build() => {};
  
  void updateFilters(Map<String, dynamic> newFilters) {
    state = {...state, ...newFilters};
  }
  
  void clearFilters() {
    state = {};
  }
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

