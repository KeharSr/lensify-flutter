// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartDto _$CartDtoFromJson(Map<String, dynamic> json) => CartDto(
      success: json['success'] as bool,
      message: json['message'] as String,
      carts: (json['carts'] as List<dynamic>)
          .map((e) => CartApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CartDtoToJson(CartDto instance) => <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'carts': instance.carts,
    };
