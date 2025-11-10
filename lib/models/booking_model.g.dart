// GENERATED CODE - DO NOT MODIFY BY HAND
// Ce fichier sera généré automatiquement par build_runner

part of 'booking_model.dart';

BookingModel _$BookingModelFromJson(Map<String, dynamic> json) => BookingModel(
      id: json['id'] as String,
      listingId: json['listing_id'] as String,
      guestId: json['guest_id'] as String,
      checkIn: DateTime.parse(json['check_in'] as String),
      checkOut: DateTime.parse(json['check_out'] as String),
      nights: json['nights'] as int,
      guests: json['guests'] as int,
      totalPrice: (json['total_price'] as num).toDouble(),
      depositAmount: (json['deposit_amount'] as num?)?.toDouble() ?? 0.0,
      status: json['status'] as String? ?? 'pending',
      paymentStatus: json['payment_status'] as String? ?? 'pending',
      paymentIntentId: json['payment_intent_id'] as String?,
      guestMessage: json['guest_message'] as String?,
      hostResponse: json['host_response'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      confirmedAt: json['confirmed_at'] != null ? DateTime.parse(json['confirmed_at'] as String) : null,
      cancelledAt: json['cancelled_at'] != null ? DateTime.parse(json['cancelled_at'] as String) : null,
    );

Map<String, dynamic> _$BookingModelToJson(BookingModel instance) => <String, dynamic>{
      'id': instance.id,
      'listing_id': instance.listingId,
      'guest_id': instance.guestId,
      'check_in': instance.checkIn.toIso8601String().split('T')[0],
      'check_out': instance.checkOut.toIso8601String().split('T')[0],
      'nights': instance.nights,
      'guests': instance.guests,
      'total_price': instance.totalPrice,
      'deposit_amount': instance.depositAmount,
      'status': instance.status,
      'payment_status': instance.paymentStatus,
      'payment_intent_id': instance.paymentIntentId,
      'guest_message': instance.guestMessage,
      'host_response': instance.hostResponse,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'confirmed_at': instance.confirmedAt?.toIso8601String(),
      'cancelled_at': instance.cancelledAt?.toIso8601String(),
    };

