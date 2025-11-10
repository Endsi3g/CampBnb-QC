// GENERATED CODE - DO NOT MODIFY BY HAND
// Ce fichier sera généré automatiquement par build_runner

part of 'profile_model.dart';

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) => ProfileModel(
      id: json['id'] as String,
      email: json['email'] as String,
      fullName: json['full_name'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      phone: json['phone'] as String?,
      bio: json['bio'] as String?,
      isHost: json['is_host'] as bool? ?? false,
      preferredLanguage: json['preferred_language'] as String? ?? 'fr',
      location: json['location'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      totalBookings: json['total_bookings'] as int? ?? 0,
      totalListings: json['total_listings'] as int? ?? 0,
      badges: (json['badges'] as List<dynamic>?)?.map((e) => e as String).toList() ?? const [],
      points: json['points'] as int? ?? 0,
    );

Map<String, dynamic> _$ProfileModelToJson(ProfileModel instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'full_name': instance.fullName,
      'avatar_url': instance.avatarUrl,
      'phone': instance.phone,
      'bio': instance.bio,
      'is_host': instance.isHost,
      'preferred_language': instance.preferredLanguage,
      'location': instance.location,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'total_bookings': instance.totalBookings,
      'total_listings': instance.totalListings,
      'badges': instance.badges,
      'points': instance.points,
    };

