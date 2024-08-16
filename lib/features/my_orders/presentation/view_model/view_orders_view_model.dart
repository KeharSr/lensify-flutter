import 'package:final_assignment/core/common/widgets/my_snackbar.dart';
import 'package:final_assignment/core/shared_prefs/user_shared_prefs.dart';
import 'package:final_assignment/features/home/presentation/navigator/home_navigator.dart';
import 'package:final_assignment/features/my_orders/presentation/state/view_orders_state.dart';
import 'package:final_assignment/features/place_order/domain/usecases/place_order_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider for PlaceOrderViewModel
final viewOrdersViewModelProvider =
    StateNotifierProvider<ViewOrdersViewModel, ViewOrdersState>(
  (ref) => ViewOrdersViewModel(
    placeOrderUseCase: ref.watch(placeOrderUseCaseProvider),
    userSharedPrefs: ref.watch(userSharedPrefsProvider),
    navigator: ref.watch(mainViewNavigatorProvider),
  ),
);

class ViewOrdersViewModel extends StateNotifier<ViewOrdersState> {
  ViewOrdersViewModel({
    required this.placeOrderUseCase,
    required this.userSharedPrefs,
    required this.navigator,
  }) : super(ViewOrdersState.initial());

  final PlaceOrderUsecase placeOrderUseCase;
  final UserSharedPrefs userSharedPrefs;
  final MainViewNavigator navigator;

  // view orders
  Future<void> getOrderByUser() async {
    state = state.copyWith(isLoading: true);
    final result = await placeOrderUseCase.getOrderByUser();

    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        showMySnackBar(message: failure.error, backgroundColor: Colors.red);
      },
      (success) {
        state = state.copyWith(
          isLoading: false,
          error: null,
          orders: success,
        );
      },
    );
  }
}
