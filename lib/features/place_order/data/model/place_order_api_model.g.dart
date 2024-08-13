// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_order_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceOrderApiModel _$PlaceOrderApiModelFromJson(Map<String, dynamic> json) =>
    PlaceOrderApiModel(
      id: json['_id'] as String?,
      userId: json['userId'] as String?,
      carts: (json['carts'] as List<dynamic>?)
          ?.map((e) => CartApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPrice: json['totalPrice'] as num,
      status: json['status'] as String,
      payment: json['payment'] as bool,
      paymentMethod: json['paymentMethod'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      street: json['street'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      zipCode: json['zipCode'] as String,
      country: json['country'] as String,
      phone: json['phone'] as String,
    );

Map<String, dynamic> _$PlaceOrderApiModelToJson(PlaceOrderApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'userId': instance.userId,
      'carts': instance.carts,
      'totalPrice': instance.totalPrice,
      'name': instance.name,
      'email': instance.email,
      'street': instance.street,
      'city': instance.city,
      'state': instance.state,
      'zipCode': instance.zipCode,
      'country': instance.country,
      'phone': instance.phone,
      'status': instance.status,
      'payment': instance.payment,
      'paymentMethod': instance.paymentMethod,
    };
