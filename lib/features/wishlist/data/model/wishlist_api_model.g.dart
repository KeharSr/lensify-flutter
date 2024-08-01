// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wishlist_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WishlistApiModel _$WishlistApiModelFromJson(Map<String, dynamic> json) =>
    WishlistApiModel(
      id: json['_id'] as String?,
      userId: json['userId'] as String?,
      product: json['product'] == null
          ? null
          : ProductApiModel.fromJson(json['product'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WishlistApiModelToJson(WishlistApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'userId': instance.userId,
      'product': instance.product,
    };
