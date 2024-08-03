import 'package:final_assignment/features/ratingandreview/domain/entity/rating_review_entity.dart';

class RatingReviewState {
  final List<RatingReviewEntity> reviews;
  final RatingReviewEntity? singleReview;
  double averageRating;
  final bool isLoading;
  final String? error;
  final String review;
  final double rating;

  RatingReviewState({
    required this.reviews,
    required this.isLoading,
    required this.singleReview,
    required this.averageRating,
    required this.review,
    required this.rating,
    this.error,
  });

  factory RatingReviewState.initial() => RatingReviewState(
        reviews: [],
        isLoading: false,
        error: null,
        singleReview: null,
        averageRating: 0.0,
        review: '',
        rating: 0.0,
      );

  RatingReviewState copyWith({
    List<RatingReviewEntity>? reviews,
    bool? isLoading,
    String? error,
    RatingReviewEntity? singleReview,
    double? averageRating,
    String? review,
    double? rating,
  }) {
    return RatingReviewState(
      reviews: reviews ?? this.reviews,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      singleReview: singleReview ?? this.singleReview,
      averageRating: averageRating ?? this.averageRating,
      review: review ?? this.review,
      rating: rating ?? this.rating,
    );
  }
}
