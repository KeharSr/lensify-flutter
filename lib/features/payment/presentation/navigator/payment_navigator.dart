import 'package:final_assignment/app/navigator/navigator.dart';
import 'package:final_assignment/features/payment/presentation/navigator/payment_success_navigator.dart';
import 'package:final_assignment/features/payment/presentation/view/payment_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final paymentViewNavigatorProvider = Provider<PaymentViewNavigator>(
  (ref) => PaymentViewNavigator(),
);

class PaymentViewNavigator with PaymentSuccessRoute {}

mixin PaymentViewRoute {
  void openPaymentView(String pidx) {
    NavigateRoute.pushRoute(PaymentView(pidx: pidx));
  }
}
