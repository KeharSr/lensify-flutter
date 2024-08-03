import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/ratingandreview/data/repository/rating_review_remote_repository.dart';
import 'package:final_assignment/features/ratingandreview/domain/entity/rating_review_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//provider
final ratingReviewRepositoryProvider = Provider<IRatingReviewRepository>(
    (ref) => ref.read(ratingReviewRemoteRepositoryProvider));

abstract class IRatingReviewRepository {
  Future<Either<Failure, double>> getRatingReviews(String productId);

  Future<Either<Failure, bool>> addRatingReview(
    String productId,
    double rating,
    String review,
  );

  // update rating review
  Future<Either<Failure, bool>> updateRatingReview(
      String productId, double rating, String review);

  // get reviews by user and product
  Future<Either<Failure, List<RatingReviewEntity>>> getReviewByProduct(
      String productId);
}
