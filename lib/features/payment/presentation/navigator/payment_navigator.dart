import 'package:final_assignment/app/navigator/navigator.dart';
import 'package:final_assignment/features/payment/presentation/view/payment_view.dart';

class PaymentViewNavigato with PaymentViewRoute {}

mixin PaymentViewRoute {
  void openPaymentView(String pidx) {
    NavigateRoute.pushRoute(PaymentView(pidx: pidx));
  }
}
