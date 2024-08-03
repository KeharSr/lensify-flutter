import 'package:final_assignment/core/common/widgets/my_snackbar.dart';
import 'package:final_assignment/core/shared_prefs/user_shared_prefs.dart';
import 'package:final_assignment/features/ratingandreview/domain/usecases/rating_review_usecase.dart';
import 'package:final_assignment/features/ratingandreview/presentation/state/rating_review_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ratingReviewViewModelProvider =
    StateNotifierProvider<RatingReviewViewModel, RatingReviewState>((ref) =>
        RatingReviewViewModel(
            ratingUseCase: ref.read(ratingReviewUsecaseProvider),
            userSharedPrefs: ref.read(userSharedPrefsProvider)));

class RatingReviewViewModel extends StateNotifier<RatingReviewState> {
  RatingReviewViewModel(
      {required this.ratingUseCase, required this.userSharedPrefs})
      : super(RatingReviewState.initial());

  final RatingReviewUsecase ratingUseCase;
  final UserSharedPrefs userSharedPrefs;

  // get rating review
  Future<void> getRatingReview(String productId) async {
    state = state.copyWith(isLoading: true);
    final result = await ratingUseCase.getRatingReview(productId);
    print(result);
    result.fold((failure) {
      state = state.copyWith(isLoading: false, error: failure.error);
      showMySnackBar(message: failure.error, backgroundColor: Colors.red);
    }, (ratingReview) {
      state = state.copyWith(isLoading: false, averageRating: ratingReview);
    });
  }

  // add rating review
  Future<void> addRatingReview(
      String productId, double rating, String review) async {
    state = state.copyWith(isLoading: true);
    final result =
        await ratingUseCase.addRatingReview(productId, rating, review);
    result.fold((failure) {
      state = state.copyWith(isLoading: false, error: failure.error);
      showMySnackBar(message: failure.error, backgroundColor: Colors.red);
    }, (isAdded) {
      state = state.copyWith(isLoading: false);
      showMySnackBar(
          message: 'Review added successfully', backgroundColor: Colors.green);
    });
    getRatingReview(productId);
  }

  // update rating review
  Future<void> updateRatingReview(
      String productId, double rating, String review) async {
    state = state.copyWith(isLoading: true);
    final result =
        await ratingUseCase.updateRatingReview(productId, rating, review);
    result.fold((failure) {
      state = state.copyWith(isLoading: false, error: failure.error);
      showMySnackBar(message: failure.error, backgroundColor: Colors.red);
    }, (isUpdated) {
      state = state.copyWith(isLoading: false);
      showMySnackBar(
          message: 'Review updated successfully',
          backgroundColor: Colors.green);
    });
    getRatingReview(productId);
  }

  // get reviews by id
  Future<void> getReviewsByProduct(String productId) async {
    state = state.copyWith(isLoading: true);
    final result = await ratingUseCase.getReviewsProduct(productId);
    result.fold((failure) {
      state = state.copyWith(isLoading: false, error: failure.error);
      showMySnackBar(message: failure.error, backgroundColor: Colors.red);
    }, (reviews) {
      state = state.copyWith(isLoading: false, reviews: reviews);
      showMySnackBar(
          message: 'Review fetched successfully',
          backgroundColor: Colors.green);
    });
  }

  // handle review submission
  void handleSubmitReview(
      BuildContext context,
      String productId,
      TextEditingController reviewController,
      double rating,
      Function(String) addReview) {
    if (reviewController.text.isNotEmpty && rating > 0) {
      addRatingReview(productId, rating, reviewController.text);
      addReview(reviewController.text);
      reviewController.clear();
      rating = 0; // Reset rating after submission
    } else {
      showMySnackBar(
          message: 'Please provide a review and rating',
          backgroundColor: Colors.red);
    }
  }
}
