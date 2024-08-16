import 'package:equatable/equatable.dart';
import 'package:final_assignment/features/product/data/model/product_api_model.dart';
import 'package:final_assignment/features/ratingandreview/domain/entity/rating_review_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rating_review_api_model.g.dart';

// Provider
final ratingReviewApiModelProvider =
    Provider((ref) => RatingReviewApiModel.empty());

@JsonSerializable()
class RatingReviewApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final ProductApiModel? productId;
  final String? user;
  final int rating;
  final String review;

  const RatingReviewApiModel({
    required this.id,
    required this.productId,
    required this.user,
    required this.rating,
    required this.review,
  });

  const RatingReviewApiModel.empty()
      : id = '',
        productId = null,
        user = '',
        rating = 0,
        review = '';

  factory RatingReviewApiModel.fromJson(Map<String, dynamic> json) =>
      _$RatingReviewApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$RatingReviewApiModelToJson(this);

  // Convert to entity
  RatingReviewEntity toEntity() {
    return RatingReviewEntity(
      id: id,
      productId: productId?.toEntity(),
      userId: user,
      rating: rating,
      review: review,
    );
  }

  // Create from entity
  factory RatingReviewApiModel.fromEntity(RatingReviewEntity entity) {
    return RatingReviewApiModel(
      id: entity.id,
      productId: ProductApiModel.fromEntity(entity.productId!),
      user: entity.userId,
      rating: entity.rating,
      review: entity.review,
    );
  }

  // Convert list of models to list of entities
  List<RatingReviewEntity> toEntityList(List<RatingReviewApiModel> reviews) {
    return reviews.map((review) => review.toEntity()).toList();
  }

  // Create list of models from list of entities
  List<RatingReviewApiModel> fromListEntity(List<RatingReviewEntity> reviews) {
    return reviews
        .map((review) => RatingReviewApiModel.fromEntity(review))
        .toList();
  }

  @override
  List<Object?> get props => [
        id,
        productId,
        user,
        rating,
        review,
      ];
}
