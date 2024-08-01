import 'package:final_assignment/features/ratingandreview/domain/entity/rating_review_entity.dart';

class RatingReviewState {
  final List<RatingReviewEntity> review;
  final bool isLoading;
  final String? error;

  RatingReviewState({
    required this.review,
    required this.isLoading,
    this.error,
  });

  factory RatingReviewState.initial() => RatingReviewState(
        review: [],
        isLoading: false,
        error: null,
      );

  RatingReviewState copyWith({
    List<RatingReviewEntity>? review,
    bool? isLoading,
    String? error,
  }) {
    return RatingReviewState(
      review: review ?? this.review,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
