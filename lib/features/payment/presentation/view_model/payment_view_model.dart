import 'package:final_assignment/core/common/widgets/my_snackbar.dart';
import 'package:final_assignment/core/shared_prefs/user_shared_prefs.dart';
import 'package:final_assignment/features/cart/domain/usecases/cart_usecase.dart';
import 'package:final_assignment/features/payment/domain/entity/payment_entity.dart';
import 'package:final_assignment/features/payment/domain/usecases/payment_usecase.dart';
import 'package:final_assignment/features/payment/presentation/state/payment_state.dart';
import 'package:final_assignment/features/place_order/presentation/navigator/place_order_navigator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../navigator/payment_navigator.dart';

//payment view model provider
final paymentViewModelProvider =
    StateNotifierProvider<PaymentViewModel, PaymentState>(
  (ref) => PaymentViewModel(
    paymentUsecase: ref.watch(paymentUsecaseProvider),
    userSharedPrefs: ref.watch(userSharedPrefsProvider),
    placeOrderViewNavigator: ref.watch(placeOrderViewNavigatorProvider),
    paymentViewNavigator: ref.watch(paymentViewNavigatorProvider),
    cartUseCase: ref.watch(cartUsecaseProvider),
  ),
);

class PaymentViewModel extends StateNotifier<PaymentState> {
  final PaymentUsecase paymentUsecase;
  final UserSharedPrefs userSharedPrefs;
  final PlaceOrderViewNavigator placeOrderViewNavigator;
  final PaymentViewNavigator paymentViewNavigator;
  final CartUsecase cartUseCase;

  PaymentViewModel({
    required this.paymentUsecase,
    required this.userSharedPrefs,
    required this.placeOrderViewNavigator,
    required this.paymentViewNavigator,
    required this.cartUseCase,
  }) : super(PaymentState.initial());

  Future<void> initializeKhaltiPayment(
      String orderId, double totalPrice) async {
    state = state.copyWith(isLoading: true);
    final data = await paymentUsecase.initializeKhaltiPayment(
        orderId: orderId, totalPrice: totalPrice);
    data.fold((l) {
      state = state.copyWith(
        isLoading: false,
      );
      showMySnackBar(message: l.error);
    }, (r) {
      state = state.copyWith(
        isLoading: false,
        error: null,
      );
      placeOrderViewNavigator.openPaymentView(r);
    });
  }

  Future<void> verifyKhaltiPayment(PaymentEntity entity) async {
    state = state.copyWith(isLoading: true);
    final data = await paymentUsecase.verifyKhaltiPayment(entity);
    data.fold((l) {
      state = state.copyWith(
        isLoading: false,
      );
      showMySnackBar(message: l.error);
    }, (r) {
      state = state.copyWith(
        isLoading: false,
        error: null,
      );
    });
  }

//   change cart status
  Future<void> changeCartStatus(String transactionId) async {
    final data = await cartUseCase.updateCartStatus();
    data.fold((l) {
      showMySnackBar(message: l.error);
    }, (r) {
      paymentViewNavigator.openPaymentSuccessView(transactionId);
    });
  }
}
