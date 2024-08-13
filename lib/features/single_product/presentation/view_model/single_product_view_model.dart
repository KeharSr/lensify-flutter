import 'package:final_assignment/core/common/widgets/my_snackbar.dart';
import 'package:final_assignment/core/shared_prefs/user_shared_prefs.dart';
import 'package:final_assignment/features/product/domain/usecase/product_usecase.dart';
import 'package:final_assignment/features/ratingandreview/domain/usecases/rating_review_usecase.dart';
import 'package:final_assignment/features/single_product/presentation/state/single_product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final singleProductViewModelProvider =
    StateNotifierProvider<SingleProductViewModel, SingleProductState>(
        (ref) => SingleProductViewModel(
              productUsecase: ref.watch(productUsecaseProvider),
              userSharedPrefs: ref.watch(userSharedPrefsProvider),
              ratingReviewUsecase: ref.watch(ratingReviewUsecaseProvider),
            ));

class SingleProductViewModel extends StateNotifier<SingleProductState> {
  SingleProductViewModel({
    required this.productUsecase,
    required this.userSharedPrefs,
    required this.ratingReviewUsecase,
  }) : super(SingleProductState.initial());

  final ProductUsecase productUsecase;
  final UserSharedPrefs userSharedPrefs;
  final RatingReviewUsecase ratingReviewUsecase;

  Future<void> getSingleProduct(String productId) async {
    state = state.copyWith(isLoading: true);
    final result = await productUsecase.getProductById(productId);
    result.fold((failure) {
      state = state.copyWith(isLoading: false, error: failure.error);
      showMySnackBar(message: failure.error, backgroundColor: Colors.red);
    }, (data) {
      state = state.copyWith(
        isLoading: false,
        singleProduct: data,
        error: null,
      );
    });
  }

  init(String productId) async {
    await getSingleProduct(productId);
    await getRatingReview(productId);
    await getReviewsByProduct(productId);
  }

  // get rating review
  Future<void> getRatingReview(String productId) async {
    state = state.copyWith(isLoading: true);
    final result = await ratingReviewUsecase.getRatingReview(productId);
    print(result);
    result.fold((failure) {
      state = state.copyWith(isLoading: false, error: failure.error);
      showMySnackBar(message: failure.error, backgroundColor: Colors.red);
    }, (ratingReview) {
      state = state.copyWith(isLoading: false, averageRating: ratingReview);
    });
  }

  void updateSelectedQuantity(int quantity) {
    if (state.singleProduct != null &&
        quantity > state.singleProduct!.productQuantity) {
      showMySnackBar(message: 'Out of stock', backgroundColor: Colors.red);
      return;
    }
    if (quantity < 1) {
      showMySnackBar(
          message: 'Quantity cannot be less 1', backgroundColor: Colors.red);
      return;
    }
    state = state.copyWith(selectedQuantity: quantity);
  }

  // add rating review
  Future<void> addRatingReview(
      String productId, double rating, String review) async {
    state = state.copyWith(isLoading: true);
    final result =
        await ratingReviewUsecase.addRatingReview(productId, rating, review);
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
        await ratingReviewUsecase.updateRatingReview(productId, rating, review);
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
    final result = await ratingReviewUsecase.getReviewsProduct(productId);
    result.fold((failure) {
      state = state.copyWith(isLoading: false, error: failure.error);
    }, (reviews) {
      state = state.copyWith(isLoading: false, reviews: reviews, error: null);
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
