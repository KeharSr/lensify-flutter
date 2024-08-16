import 'package:final_assignment/app/navigator/navigator.dart';
import 'package:final_assignment/features/payment/presentation/navigator/payment_navigator.dart';
import 'package:final_assignment/features/place_order/presentation/view/place_order_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../cart/domain/entity/cart_entity.dart';

final placeOrderViewNavigatorProvider =
    Provider((ref) => PlaceOrderViewNavigator());

class PlaceOrderViewNavigator with PaymentViewRoute {}

mixin PlaceOrderViewRoute {
  void openPlaceOrderView(List<CartEntity> carts) {
    NavigateRoute.pushRoute(PlaceOrderView(
      cartItems: carts,
    ));
  }
}
