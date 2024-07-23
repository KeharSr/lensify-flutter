// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartApiModel _$CartApiModelFromJson(Map<String, dynamic> json) => CartApiModel(
      id: json['_id'] as String?,
      userId: json['userId'] as String?,
      productId: json['productId'] == null
          ? null
          : ProductApiModel.fromJson(json['productId'] as Map<String, dynamic>),
      quantity: (json['quantity'] as num).toInt(),
      status: json['status'] as String,
    );

Map<String, dynamic> _$CartApiModelToJson(CartApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'userId': instance.userId,
      'productId': instance.productId,
      'quantity': instance.quantity,
      'status': instance.status,
    };
