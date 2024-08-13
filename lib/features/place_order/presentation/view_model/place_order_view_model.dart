import 'package:final_assignment/core/common/widgets/my_snackbar.dart';
import 'package:final_assignment/core/shared_prefs/user_shared_prefs.dart';
import 'package:final_assignment/features/home/presentation/navigator/home_navigator.dart';
import 'package:final_assignment/features/place_order/domain/entity/place_order_entity.dart';
import 'package:final_assignment/features/place_order/domain/usecases/place_order_usecase.dart';
import 'package:final_assignment/features/place_order/presentation/state/place_order_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider for PlaceOrderViewModel
final placeOrderViewModelProvider =
    StateNotifierProvider<PlaceOrderViewModel, PlaceOrderState>(
  (ref) => PlaceOrderViewModel(
    placeOrderUseCase: ref.watch(placeOrderUseCaseProvider),
    userSharedPrefs: ref.watch(userSharedPrefsProvider),
    navigator: ref.watch(mainViewNavigatorProvider),
  ),
);

class PlaceOrderViewModel extends StateNotifier<PlaceOrderState> {
  PlaceOrderViewModel({
    required this.placeOrderUseCase,
    required this.userSharedPrefs,
    required this.navigator,
  }) : super(PlaceOrderState.initial());

  final PlaceOrderUsecase placeOrderUseCase;
  final UserSharedPrefs userSharedPrefs;
  final MainViewNavigator navigator;

  // Place an order
  Future<void> placeOrder(
    PlaceOrderEntity placeOrderEntity,
  ) async {
    state = state.copyWith(isLoading: true);
    final result = await placeOrderUseCase.placeOrder(
      placeOrderEntity,
    );

    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        showMySnackBar(message: failure.error, backgroundColor: Colors.red);
      },
      (success) {
        state = state.copyWith(
          isLoading: false,
          error: null,
          placeOrder: success,
        );
        // If placing the order is successful, initialize Khalti payment
      },
    );
  }
}
