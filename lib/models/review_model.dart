import 'package:json_annotation/json_annotation.dart';

part 'review_model.g.dart';

@JsonSerializable()
class ReviewModel {
  final String id;
  final String bookingId;
  final String listingId;
  final String reviewerId;
  final String revieweeId;
  final int rating;
  final String? comment;
  final int? cleanlinessRating;
  final int? communicationRating;
  final int? locationRating;
  final int? valueRating;
  final String? aiSummary;
  final double? sentimentScore;
  final DateTime createdAt;
  final DateTime updatedAt;
  
  ReviewModel({
    required this.id,
    required this.bookingId,
    required this.listingId,
    required this.reviewerId,
    required this.revieweeId,
    required this.rating,
    this.comment,
    this.cleanlinessRating,
    this.communicationRating,
    this.locationRating,
    this.valueRating,
    this.aiSummary,
    this.sentimentScore,
    required this.createdAt,
    required this.updatedAt,
  });
  
  factory ReviewModel.fromJson(Map<String, dynamic> json) => 
    _$ReviewModelFromJson(json);
  
  Map<String, dynamic> toJson() => _$ReviewModelToJson(this);
}

