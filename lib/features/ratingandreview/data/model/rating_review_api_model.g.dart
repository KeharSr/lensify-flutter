// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rating_review_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RatingReviewApiModel _$RatingReviewApiModelFromJson(
        Map<String, dynamic> json) =>
    RatingReviewApiModel(
      id: json['_id'] as String?,
      productId: json['productId'] == null
          ? null
          : ProductApiModel.fromJson(json['productId'] as Map<String, dynamic>),
      userId: json['userId'] as String?,
      rating: (json['rating'] as num).toInt(),
      review: json['review'] as String,
    );

Map<String, dynamic> _$RatingReviewApiModelToJson(
        RatingReviewApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'productId': instance.productId,
      'userId': instance.userId,
      'rating': instance.rating,
      'review': instance.review,
    };
