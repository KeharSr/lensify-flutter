import 'package:equatable/equatable.dart';
import 'package:final_assignment/features/product/domain/entity/product_entity.dart';

class RatingReviewEntity extends Equatable {
  final String? id;
  final ProductEntity? productId;
  final String? userId;
  final int rating;
  final String review;

  const RatingReviewEntity({
    this.id,
    this.productId,
    this.userId,
    required this.rating,
    required this.review,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        productId,
        userId,
        rating,
        review,
      ];
}
