import 'package:equatable/equatable.dart';
import 'package:final_assignment/features/product/domain/entity/product_entity.dart';

class RatingReviewEntity extends Equatable {
  final String? id;
  final ProductEntity? productId;
  final String? userId;
  final int rating;
  final String review;

  const RatingReviewEntity({
    required this.id,
    required this.productId,
    required this.userId,
    required this.rating,
    required this.review,
  });

  @override

  List<Object?> get props => [
        id,
        productId,
        userId,
        rating,
        review,
      ];
}
