// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listing_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListingModel _$ListingModelFromJson(Map<String, dynamic> json) => ListingModel(
      id: json['id'] as String,
      hostId: json['hostId'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      listingType: json['listingType'] as String,
      address: json['address'] as String,
      city: json['city'] as String,
      region: json['region'] as String,
      postalCode: json['postalCode'] as String?,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      pricePerNight: (json['pricePerNight'] as num).toDouble(),
      maxGuests: (json['maxGuests'] as num).toInt(),
      minNights: (json['minNights'] as num?)?.toInt() ?? 1,
      maxNights: (json['maxNights'] as num?)?.toInt(),
      amenities: (json['amenities'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      photos: (json['photos'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      houseRules: json['houseRules'] as String?,
      cancellationPolicy: json['cancellationPolicy'] as String? ?? 'moderate',
      status: json['status'] as String? ?? 'active',
      isFeatured: json['isFeatured'] as bool? ?? false,
      viewCount: (json['viewCount'] as num?)?.toInt() ?? 0,
      ratingAverage: (json['ratingAverage'] as num?)?.toDouble() ?? 0.0,
      reviewCount: (json['reviewCount'] as num?)?.toInt() ?? 0,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$ListingModelToJson(ListingModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'hostId': instance.hostId,
      'title': instance.title,
      'description': instance.description,
      'listingType': instance.listingType,
      'address': instance.address,
      'city': instance.city,
      'region': instance.region,
      'postalCode': instance.postalCode,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'pricePerNight': instance.pricePerNight,
      'maxGuests': instance.maxGuests,
      'minNights': instance.minNights,
      'maxNights': instance.maxNights,
      'amenities': instance.amenities,
      'photos': instance.photos,
      'houseRules': instance.houseRules,
      'cancellationPolicy': instance.cancellationPolicy,
      'status': instance.status,
      'isFeatured': instance.isFeatured,
      'viewCount': instance.viewCount,
      'ratingAverage': instance.ratingAverage,
      'reviewCount': instance.reviewCount,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
