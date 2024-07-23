import 'package:final_assignment/app/navigator/navigator.dart';
import 'package:final_assignment/features/auth/presentation/navigator/login_navigator.dart';
import 'package:final_assignment/features/cart/presentation/navigator/cart_navigator.dart';
import 'package:final_assignment/features/home/presentation/view/main_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mainViewNavigatorProvider = Provider<MainViewNavigator>((ref) {
  return MainViewNavigator();
});

class MainViewNavigator with LoginViewRoute, CartViewRoute {}

mixin HomeViewRoute {
  openHomeView() {
    NavigateRoute.popAndPushRoute(const MainView());
  }
}
