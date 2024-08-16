import 'package:final_assignment/features/product/domain/entity/product_entity.dart';
import 'package:final_assignment/features/ratingandreview/domain/entity/rating_review_entity.dart';

import '../../../auth/domain/entity/auth_entity.dart';

class SingleProductState {
  final ProductEntity? singleProduct;
  final bool isLoading;
  final String? error;
  final int selectedQuantity;
  final List<RatingReviewEntity> reviews;
  final RatingReviewEntity? singleReview;
  double averageRating;
  final String review;
  final double rating;
  final bool selectedreview;
  final AuthEntity? auth;

  SingleProductState({
    required this.singleProduct,
    required this.isLoading,
    required this.error,
    required this.selectedQuantity,
    required this.reviews,
    required this.singleReview,
    required this.averageRating,
    required this.review,
    required this.rating,
    required this.selectedreview,
    required this.auth,
  });

  factory SingleProductState.initial() => SingleProductState(
        singleProduct: null,
        isLoading: false,
        error: null,
        selectedQuantity: 1,
        reviews: [],
        singleReview: null,
        averageRating: 0.0,
        review: '',
        rating: 0.0,
        selectedreview: false,
        auth: null,
      );

  SingleProductState copyWith({
    ProductEntity? singleProduct,
    bool? isLoading,
    String? error,
    int? selectedQuantity,
    List<RatingReviewEntity>? reviews,
    RatingReviewEntity? singleReview,
    double? averageRating,
    String? review,
    double? rating,
    bool? selectedreview,
    AuthEntity? auth,
  }) {
    return SingleProductState(
      singleProduct: singleProduct ?? this.singleProduct,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      selectedQuantity: selectedQuantity ?? this.selectedQuantity,
      reviews: reviews ?? this.reviews,
      singleReview: singleReview ?? this.singleReview,
      averageRating: averageRating ?? this.averageRating,
      review: review ?? this.review,
      rating: rating ?? this.rating,
      selectedreview: selectedreview ?? this.selectedreview,
      auth: auth ?? this.auth,
    );
  }
}
