// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rating_review_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RatingReviewDto _$RatingReviewDtoFromJson(Map<String, dynamic> json) =>
    RatingReviewDto(
      success: json['success'] as bool,
      message: json['message'] as String,
      averageRating: (json['averageRating'] as num).toDouble(),
      count: (json['count'] as num).toInt(),
      productId: json['productId'] as String,
    );

Map<String, dynamic> _$RatingReviewDtoToJson(RatingReviewDto instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'averageRating': instance.averageRating,
      'count': instance.count,
      'productId': instance.productId,
    };
