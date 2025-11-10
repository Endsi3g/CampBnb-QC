import 'package:json_annotation/json_annotation.dart';

part 'listing_model.g.dart';

@JsonSerializable()
class ListingModel {
  final String id;
  final String hostId;
  final String title;
  final String description;
  final String listingType; // tent, rv, cabin, van, glamping, other
  final String address;
  final String city;
  final String region;
  final String? postalCode;
  final double latitude;
  final double longitude;
  final double pricePerNight;
  final int maxGuests;
  final int minNights;
  final int? maxNights;
  final List<String> amenities;
  final List<String> photos;
  final String? houseRules;
  final String cancellationPolicy;
  final String status; // active, inactive, pending, rejected
  final bool isFeatured;
  final int viewCount;
  final double ratingAverage;
  final int reviewCount;
  final DateTime createdAt;
  final DateTime updatedAt;
  
  ListingModel({
    required this.id,
    required this.hostId,
    required this.title,
    required this.description,
    required this.listingType,
    required this.address,
    required this.city,
    required this.region,
    this.postalCode,
    required this.latitude,
    required this.longitude,
    required this.pricePerNight,
    required this.maxGuests,
    this.minNights = 1,
    this.maxNights,
    this.amenities = const [],
    this.photos = const [],
    this.houseRules,
    this.cancellationPolicy = 'moderate',
    this.status = 'active',
    this.isFeatured = false,
    this.viewCount = 0,
    this.ratingAverage = 0.0,
    this.reviewCount = 0,
    required this.createdAt,
    required this.updatedAt,
  });
  
  factory ListingModel.fromJson(Map<String, dynamic> json) => 
    _$ListingModelFromJson(json);
  
  Map<String, dynamic> toJson() => _$ListingModelToJson(this);
  
  String get mainPhoto => photos.isNotEmpty ? photos.first : '';
  
  bool get hasPhotos => photos.isNotEmpty;
}

