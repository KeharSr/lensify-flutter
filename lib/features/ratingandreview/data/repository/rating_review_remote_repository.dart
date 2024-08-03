import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/ratingandreview/data/data_source/remote/rating_review_remote_data_source.dart';
import 'package:final_assignment/features/ratingandreview/domain/entity/rating_review_entity.dart';
import 'package:final_assignment/features/ratingandreview/domain/repository/rating_review_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ratingReviewRemoteRepositoryProvider =
    Provider<RatingReviewRemoteRepository>((ref) {
  final ratingReviewRemoteDataSource =
      ref.read(ratingReviewRemoteDataSourceProvider);
  return RatingReviewRemoteRepository(
      ratingReviewRemoteDataSource: ratingReviewRemoteDataSource);
});

class RatingReviewRemoteRepository implements IRatingReviewRepository {
  final RatingReviewRemoteDataSource ratingReviewRemoteDataSource;

  RatingReviewRemoteRepository({required this.ratingReviewRemoteDataSource});

  @override
  Future<Either<Failure, double>> getRatingReviews(String productId) {
    return ratingReviewRemoteDataSource.getReviewRating(productId: productId);
  }

  @override
  Future<Either<Failure, bool>> addRatingReview(
    String productId,
    double rating,
    String review,
  ) {
    return ratingReviewRemoteDataSource.addReviewRating(
        productId: productId, rating: rating, review: review);
  }

  @override
  Future<Either<Failure, bool>> updateRatingReview(
      String productId, double rating, String review) {
    return ratingReviewRemoteDataSource.updateReviewRating(
        productId: productId, rating: rating, review: review);
  }

  // get reviews by productid
  @override
  Future<Either<Failure, List<RatingReviewEntity>>> getReviewByProduct(
      String productId) {
    return ratingReviewRemoteDataSource.getReviewsProduct(productId: productId);
  }
}
