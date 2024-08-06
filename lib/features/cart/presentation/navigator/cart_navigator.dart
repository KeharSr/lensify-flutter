import 'package:final_assignment/app/navigator/navigator.dart';
import 'package:final_assignment/features/cart/presentation/view/cart_view.dart';
import 'package:final_assignment/features/home/presentation/navigator/home_navigator.dart';

class CartViewNavigator with HomeViewRoute{}

mixin CartViewRoute  {
  void navigateToCartView() {
    NavigateRoute.pushRoute(const CartView());
  }
}
