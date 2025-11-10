import 'package:json_annotation/json_annotation.dart';

part 'booking_model.g.dart';

@JsonSerializable()
class BookingModel {
  final String id;
  final String listingId;
  final String guestId;
  final DateTime checkIn;
  final DateTime checkOut;
  final int nights;
  final int guests;
  final double totalPrice;
  final double depositAmount;
  final String status; // pending, confirmed, cancelled, completed, rejected
  final String paymentStatus; // pending, paid, refunded, failed
  final String? paymentIntentId;
  final String? guestMessage;
  final String? hostResponse;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? confirmedAt;
  final DateTime? cancelledAt;
  
  BookingModel({
    required this.id,
    required this.listingId,
    required this.guestId,
    required this.checkIn,
    required this.checkOut,
    required this.nights,
    required this.guests,
    required this.totalPrice,
    this.depositAmount = 0.0,
    this.status = 'pending',
    this.paymentStatus = 'pending',
    this.paymentIntentId,
    this.guestMessage,
    this.hostResponse,
    required this.createdAt,
    required this.updatedAt,
    this.confirmedAt,
    this.cancelledAt,
  });
  
  factory BookingModel.fromJson(Map<String, dynamic> json) => 
    _$BookingModelFromJson(json);
  
  Map<String, dynamic> toJson() => _$BookingModelToJson(this);
  
  bool get isPending => status == 'pending';
  bool get isConfirmed => status == 'confirmed';
  bool get isCancelled => status == 'cancelled';
  bool get isCompleted => status == 'completed';
}

