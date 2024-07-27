import 'package:final_assignment/core/common/widgets/my_snackbar.dart';
import 'package:final_assignment/core/common/widgets/my_yes_no_dialog.dart';
import 'package:final_assignment/core/shared_prefs/user_shared_prefs.dart';
import 'package:final_assignment/features/home/presentation/navigator/home_navigator.dart';
import 'package:final_assignment/features/product/domain/usecase/product_usecase.dart';
import 'package:final_assignment/features/product/presentation/state/product_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productViewModelProvider =
    StateNotifierProvider<ProductViewmodel, ProductState>(
  (ref) => ProductViewmodel(
    navigator: ref.watch(mainViewNavigatorProvider),
    productUsecase: ref.watch(productUsecaseProvider),
    userSharedPrefs: ref.watch(userSharedPrefsProvider),
  ),
);

class ProductViewmodel extends StateNotifier<ProductState> {
  ProductViewmodel({
    required this.navigator,
    required this.productUsecase,
    required this.userSharedPrefs,
  }) : super(ProductState.initial()) {
    getProductsByCategory('All');
  }

  final MainViewNavigator navigator;
  final ProductUsecase productUsecase;
  final UserSharedPrefs userSharedPrefs;

  void openLoginView() {
    navigator.openLoginView();
  }

  void openCartView() {
    navigator.navigateToCartView();
  }

  Future resetState(String category) async {
    state = ProductState.initial();
    getProductsByCategory(category);
  }

  Future logout() async {
    final accept =
        await myYesNoDialog(title: 'Are you sure you want to logout?');

    if (accept) {
      final result = await userSharedPrefs.removeUserToken();
      result.fold(
        (failure) => state = state.copyWith(
          isLoading: false,
          error: failure.error,
        ),
        (success) {
          state = state.copyWith(isLoading: false, error: null);
          showMySnackBar(message: "Successfully logged out");
          openLoginView();
        },
      );
    }
  }

  // get products by category
  Future<void> getProductsByCategory(String category) async {
    state = state.copyWith(isLoading: true);
    final currentState = state;
    final page = currentState.page + 1;
    final products = currentState.products;
    final hasReachedMax = currentState.hasReachedMax;
    if (!hasReachedMax) {
      // get data from data source
      final result =
          await productUsecase.getProductsByCategory(page, 2, category);
      result.fold(
        (failure) =>
            state = state.copyWith(hasReachedMax: true, isLoading: false),
        (data) {
          if (data.isEmpty) {
            state = state.copyWith(hasReachedMax: true);
          } else {
            state = state.copyWith(
              products: [...products, ...data],
              page: page,
              isLoading: false,
            );
          }
        },
      );
    }
  }

  
}
