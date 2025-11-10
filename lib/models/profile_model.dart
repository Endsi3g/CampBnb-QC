import 'package:json_annotation/json_annotation.dart';

part 'profile_model.g.dart';

@JsonSerializable()
class ProfileModel {
  final String id;
  final String email;
  final String? fullName;
  final String? avatarUrl;
  final String? phone;
  final String? bio;
  final bool isHost;
  final String preferredLanguage;
  final String? location;
  final DateTime createdAt;
  final DateTime updatedAt;
  
  // Gamification
  final int totalBookings;
  final int totalListings;
  final List<String> badges;
  final int points;
  
  ProfileModel({
    required this.id,
    required this.email,
    this.fullName,
    this.avatarUrl,
    this.phone,
    this.bio,
    this.isHost = false,
    this.preferredLanguage = 'fr',
    this.location,
    required this.createdAt,
    required this.updatedAt,
    this.totalBookings = 0,
    this.totalListings = 0,
    this.badges = const [],
    this.points = 0,
  });
  
  factory ProfileModel.fromJson(Map<String, dynamic> json) => 
    _$ProfileModelFromJson(json);
  
  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
  
  ProfileModel copyWith({
    String? id,
    String? email,
    String? fullName,
    String? avatarUrl,
    String? phone,
    String? bio,
    bool? isHost,
    String? preferredLanguage,
    String? location,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? totalBookings,
    int? totalListings,
    List<String>? badges,
    int? points,
  }) {
    return ProfileModel(
      id: id ?? this.id,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      phone: phone ?? this.phone,
      bio: bio ?? this.bio,
      isHost: isHost ?? this.isHost,
      preferredLanguage: preferredLanguage ?? this.preferredLanguage,
      location: location ?? this.location,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      totalBookings: totalBookings ?? this.totalBookings,
      totalListings: totalListings ?? this.totalListings,
      badges: badges ?? this.badges,
      points: points ?? this.points,
    );
  }
}

