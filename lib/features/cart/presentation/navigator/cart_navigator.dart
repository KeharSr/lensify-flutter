import 'package:final_assignment/app/navigator/navigator.dart';
import 'package:final_assignment/features/cart/presentation/view/cart_view.dart';

class CartViewNavigator {}

mixin CartViewRoute {
  void navigateToCartView() {
    NavigateRoute.pushRoute(const CartView());
  }
}
