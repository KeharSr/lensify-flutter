// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentApiModel _$PaymentApiModelFromJson(Map<String, dynamic> json) =>
    PaymentApiModel(
      id: json['_id'] as String?,
      transactionId: json['transactionId'] as String,
      pidx: json['pidx'] as String,
      orderId: json['orderId'] as String,
      totalPrice: (json['totalPrice'] as num).toDouble(),
      dataFromVerificationReq:
          json['dataFromVerificationReq'] as Map<String, dynamic>?,
      apiQueryFromUser: json['apiQueryFromUser'] as Map<String, dynamic>?,
      paymentGateway: json['paymentGateway'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$PaymentApiModelToJson(PaymentApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'transactionId': instance.transactionId,
      'pidx': instance.pidx,
      'orderId': instance.orderId,
      'totalPrice': instance.totalPrice,
      'dataFromVerificationReq': instance.dataFromVerificationReq,
      'apiQueryFromUser': instance.apiQueryFromUser,
      'paymentGateway': instance.paymentGateway,
      'status': instance.status,
    };
