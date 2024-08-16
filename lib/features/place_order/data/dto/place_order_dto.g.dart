// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_order_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceOrderDto _$PlaceOrderDtoFromJson(Map<String, dynamic> json) =>
    PlaceOrderDto(
      success: json['success'] as bool,
      message: json['message'] as String,
      orders: (json['orders'] as List<dynamic>)
          .map((e) => PlaceOrderApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PlaceOrderDtoToJson(PlaceOrderDto instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'orders': instance.orders,
    };
