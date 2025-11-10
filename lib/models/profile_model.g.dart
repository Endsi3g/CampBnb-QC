// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) => ProfileModel(
      id: json['id'] as String,
      email: json['email'] as String,
      fullName: json['fullName'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      phone: json['phone'] as String?,
      bio: json['bio'] as String?,
      isHost: json['isHost'] as bool? ?? false,
      preferredLanguage: json['preferredLanguage'] as String? ?? 'fr',
      location: json['location'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      totalBookings: (json['totalBookings'] as num?)?.toInt() ?? 0,
      totalListings: (json['totalListings'] as num?)?.toInt() ?? 0,
      badges: (json['badges'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      points: (json['points'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$ProfileModelToJson(ProfileModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'fullName': instance.fullName,
      'avatarUrl': instance.avatarUrl,
      'phone': instance.phone,
      'bio': instance.bio,
      'isHost': instance.isHost,
      'preferredLanguage': instance.preferredLanguage,
      'location': instance.location,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'totalBookings': instance.totalBookings,
      'totalListings': instance.totalListings,
      'badges': instance.badges,
      'points': instance.points,
    };
