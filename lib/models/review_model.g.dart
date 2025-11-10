// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewModel _$ReviewModelFromJson(Map<String, dynamic> json) => ReviewModel(
      id: json['id'] as String,
      bookingId: json['bookingId'] as String,
      listingId: json['listingId'] as String,
      reviewerId: json['reviewerId'] as String,
      revieweeId: json['revieweeId'] as String,
      rating: (json['rating'] as num).toInt(),
      comment: json['comment'] as String?,
      cleanlinessRating: (json['cleanlinessRating'] as num?)?.toInt(),
      communicationRating: (json['communicationRating'] as num?)?.toInt(),
      locationRating: (json['locationRating'] as num?)?.toInt(),
      valueRating: (json['valueRating'] as num?)?.toInt(),
      aiSummary: json['aiSummary'] as String?,
      sentimentScore: (json['sentimentScore'] as num?)?.toDouble(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$ReviewModelToJson(ReviewModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'bookingId': instance.bookingId,
      'listingId': instance.listingId,
      'reviewerId': instance.reviewerId,
      'revieweeId': instance.revieweeId,
      'rating': instance.rating,
      'comment': instance.comment,
      'cleanlinessRating': instance.cleanlinessRating,
      'communicationRating': instance.communicationRating,
      'locationRating': instance.locationRating,
      'valueRating': instance.valueRating,
      'aiSummary': instance.aiSummary,
      'sentimentScore': instance.sentimentScore,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
