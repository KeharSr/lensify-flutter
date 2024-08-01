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
  Future<void> getRatingReview() async {
    state = state.copyWith(isLoading: true);
    final result = await ratingUseCase.getRatingReview();
    result.fold((failure) {
      state = state.copyWith(isLoading: false, error: failure.error);
      showMySnackBar(message: failure.error, backgroundColor: Colors.red);
    }, (ratingReview) {
      state = state.copyWith(isLoading: false, review: ratingReview);
    });
  }
}
