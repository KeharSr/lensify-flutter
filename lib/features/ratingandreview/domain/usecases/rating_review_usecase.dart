import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/ratingandreview/domain/entity/rating_review_entity.dart';
import 'package:final_assignment/features/ratingandreview/domain/repository/rating_review_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//provider
final ratingReviewUsecaseProvider = Provider<RatingReviewUsecase>((ref) {
  final ratingReviewRepository = ref.read(ratingReviewRepositoryProvider);
  return RatingReviewUsecase(ratingReviewRepository);
});

class RatingReviewUsecase {
  final IRatingReviewRepository ratingReviewRepository;

  RatingReviewUsecase(this.ratingReviewRepository);

  Future<Either<Failure, List<RatingReviewEntity>>> getRatingReview() async {
    return await ratingReviewRepository.getRatingReviews();
  }
}
