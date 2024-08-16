import 'package:final_assignment/features/payment/presentation/view/payment_success.dart';

import '../../../../app/navigator/navigator.dart';

class PaymentSuccessNavigator {}

mixin PaymentSuccessRoute {
  void openPaymentSuccessView(String transactionId) {
    NavigateRoute.pushRoute(PaymentSuccess(transactionId: transactionId));
  }
}
