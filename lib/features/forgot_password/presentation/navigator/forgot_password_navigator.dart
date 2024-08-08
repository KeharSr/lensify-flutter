import 'package:final_assignment/app/navigator/navigator.dart';
import 'package:final_assignment/features/auth/presentation/navigator/login_navigator.dart';
import 'package:final_assignment/features/forgot_password/presentation/view/forgot_password_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final forgetPasswordViewNavigatorProvider =
    Provider((ref) => ForgotPasswordViewNavigator());

class ForgotPasswordViewNavigator with LoginViewRoute {}

mixin ForgotPasswordViewRoute {
  openForgotPasswordView() {
    NavigateRoute.popAndPushRoute(const ForgetPasswordView());
  }
}
