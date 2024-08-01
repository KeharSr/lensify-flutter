// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wishlist_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WishlistDto _$WishlistDtoFromJson(Map<String, dynamic> json) => WishlistDto(
      success: json['success'] as bool,
      message: json['message'] as String,
      favorites: (json['favorites'] as List<dynamic>)
          .map((e) => WishlistApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WishlistDtoToJson(WishlistDto instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'favorites': instance.favorites,
    };
