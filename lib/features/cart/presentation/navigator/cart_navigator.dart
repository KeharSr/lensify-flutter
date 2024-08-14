import 'package:final_assignment/app/navigator/navigator.dart';
import 'package:final_assignment/features/cart/presentation/view/cart_view.dart';
import 'package:final_assignment/features/home/presentation/navigator/home_navigator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../place_order/presentation/navigator/place_order_navigator.dart';

final cartViewNavigatorProvider = Provider((ref) => CartViewNavigator());

class CartViewNavigator with HomeViewRoute, PlaceOrderViewRoute {}

mixin CartViewRoute {
  void navigateToCartView() {
    NavigateRoute.pushRoute(const CartView());
  }
}
