// GENERATED CODE - DO NOT MODIFY BY HAND
// Ce fichier sera généré automatiquement par build_runner

part of 'review_model.dart';

ReviewModel _$ReviewModelFromJson(Map<String, dynamic> json) => ReviewModel(
      id: json['id'] as String,
      bookingId: json['booking_id'] as String,
      listingId: json['listing_id'] as String,
      reviewerId: json['reviewer_id'] as String,
      revieweeId: json['reviewee_id'] as String,
      rating: json['rating'] as int,
      comment: json['comment'] as String?,
      cleanlinessRating: json['cleanliness_rating'] as int?,
      communicationRating: json['communication_rating'] as int?,
      locationRating: json['location_rating'] as int?,
      valueRating: json['value_rating'] as int?,
      aiSummary: json['ai_summary'] as String?,
      sentimentScore: (json['sentiment_score'] as num?)?.toDouble(),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$ReviewModelToJson(ReviewModel instance) => <String, dynamic>{
      'id': instance.id,
      'booking_id': instance.bookingId,
      'listing_id': instance.listingId,
      'reviewer_id': instance.reviewerId,
      'reviewee_id': instance.revieweeId,
      'rating': json['rating'] as int,
      'comment': instance.comment,
      'cleanliness_rating': instance.cleanlinessRating,
      'communication_rating': instance.communicationRating,
      'location_rating': instance.locationRating,
      'value_rating': instance.valueRating,
      'ai_summary': instance.aiSummary,
      'sentiment_score': instance.sentimentScore,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };

