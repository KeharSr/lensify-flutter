// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rating_review_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RatingReviewDto _$RatingReviewDtoFromJson(Map<String, dynamic> json) =>
    RatingReviewDto(
      success: json['success'] as bool,
      message: json['message'] as String,
      review: (json['review'] as List<dynamic>)
          .map((e) => RatingReviewApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RatingReviewDtoToJson(RatingReviewDto instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'review': instance.review,
    };
