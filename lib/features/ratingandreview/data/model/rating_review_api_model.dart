import 'package:equatable/equatable.dart';
import 'package:final_assignment/features/product/data/model/product_api_model.dart';
import 'package:final_assignment/features/ratingandreview/domain/entity/rating_review_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rating_review_api_model.g.dart';

//provider
final ratingReviewApiModelProvider =
    Provider((ref) => RatingReviewApiModel.empty());

@JsonSerializable()
class RatingReviewApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final ProductApiModel? productId;
  final String? userId;
  final int rating;
  final String review;

  const RatingReviewApiModel({
    this.id,
    this.productId,
    this.userId,
    required this.rating,
    required this.review,
  });

  const RatingReviewApiModel.empty()
      : id = '',
        productId = null,
        userId = '',
        rating = 0,
        review = '';

  factory RatingReviewApiModel.fromJson(Map<String, dynamic> json) =>
      _$RatingReviewApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$RatingReviewApiModelToJson(this);

  // to entity
  RatingReviewEntity toEntity() {
    return RatingReviewEntity(
      id: id,
      productId: productId!.toEntity(),
      userId: userId,
      rating: rating,
      review: review,
    );
  }

  // to  model
  factory RatingReviewApiModel.fromEntity(RatingReviewEntity entity) {
    return RatingReviewApiModel(
      id: entity.id,
      productId: ProductApiModel.fromEntity(entity.productId!),
      userId: entity.userId,
      rating: entity.rating,
      review: entity.review,
    );
  }

  // to list entity
  List<RatingReviewEntity> toEntityList(List<RatingReviewApiModel> reviews) {
    return reviews.map((review) => review.toEntity()).toList();
  }

  // From list entity
  List<RatingReviewApiModel> fromListEntity(List<RatingReviewEntity> reviews) {
    return reviews
        .map((review) => RatingReviewApiModel.fromEntity(review))
        .toList();
  }

  @override
  List<Object?> get props => [
        id,
        productId,
        userId,
        rating,
        review,
      ];
}
