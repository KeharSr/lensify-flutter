import 'package:final_assignment/core/common/widgets/my_snackbar.dart';
import 'package:final_assignment/core/shared_prefs/user_shared_prefs.dart';
import 'package:final_assignment/features/payment/domain/usecases/payment_usecase.dart';
import 'package:final_assignment/features/payment/presentation/state/payment_state.dart';
import 'package:final_assignment/features/place_order/presentation/navigator/place_order_navigator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//payment view model provider
final paymentViewModelProvider =
    StateNotifierProvider<PaymentViewModel, PaymentState>(
  (ref) => PaymentViewModel(
    paymentUsecase: ref.watch(paymentUsecaseProvider),
    userSharedPrefs: ref.watch(userSharedPrefsProvider),
    placeOrderViewNavigator: ref.watch(placeOrderViewNavigatorProvider),
  ),
);

class PaymentViewModel extends StateNotifier<PaymentState> {
  final PaymentUsecase paymentUsecase;
  final UserSharedPrefs userSharedPrefs;
  final PlaceOrderViewNavigator placeOrderViewNavigator;

  PaymentViewModel({
    required this.paymentUsecase,
    required this.userSharedPrefs,
    required this.placeOrderViewNavigator,
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
}
