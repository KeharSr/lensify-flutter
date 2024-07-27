import 'package:final_assignment/core/common/widgets/my_snackbar.dart';
import 'package:final_assignment/core/shared_prefs/user_shared_prefs.dart';
import 'package:final_assignment/features/product/domain/usecase/product_usecase.dart';
import 'package:final_assignment/features/single_product/presentation/state/single_product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final singleProductViewModelProvider =
    StateNotifierProvider<SingleProductViewModel, SingleProductState>(
        (ref) => SingleProductViewModel(
              productUsecase: ref.watch(productUsecaseProvider),
              userSharedPrefs: ref.watch(userSharedPrefsProvider),
            ));

class SingleProductViewModel extends StateNotifier<SingleProductState> {
  SingleProductViewModel({
    required this.productUsecase,
    required this.userSharedPrefs,
  }) : super(SingleProductState.initial());

  final ProductUsecase productUsecase;
  final UserSharedPrefs userSharedPrefs;

  Future<void> getSingleProduct(String productId) async {
    state = state.copyWith(isLoading: true);
    final result = await productUsecase.getProductById(productId);
    result.fold((failure) {
      state = state.copyWith(isLoading: false, error: failure.error);
      showMySnackBar(message: failure.error, color: Colors.red);
    }, (data) {
      state = state.copyWith(
        isLoading: false,
        singleProduct: data,
        error: null,
      );
    });
  }
}
