// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reviews_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewsDto _$ReviewsDtoFromJson(Map<String, dynamic> json) => ReviewsDto(
      success: json['success'] as bool,
      message: json['message'] as String,
      reviews: (json['reviews'] as List<dynamic>)
          .map((e) => RatingReviewApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReviewsDtoToJson(ReviewsDto instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'reviews': instance.reviews,
    };
