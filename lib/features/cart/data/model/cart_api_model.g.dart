// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartApiModel _$CartApiModelFromJson(Map<String, dynamic> json) => CartApiModel(
      id: json['_id'] as String?,
      userId: json['userId'] as String,
      productId: json['productId'] as String,
      quantity: (json['quantity'] as num).toInt(),
      productName: json['productName'] as String,
      productImage: json['productImage'] as String,
      productPrice: (json['productPrice'] as num).toInt(),
      productDescription: json['productDescription'] as String,
    );

Map<String, dynamic> _$CartApiModelToJson(CartApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'userId': instance.userId,
      'productId': instance.productId,
      'quantity': instance.quantity,
      'productName': instance.productName,
      'productImage': instance.productImage,
      'productPrice': instance.productPrice,
      'productDescription': instance.productDescription,
    };
