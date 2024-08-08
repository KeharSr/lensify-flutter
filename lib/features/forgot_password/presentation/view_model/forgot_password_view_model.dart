import 'package:final_assignment/core/common/widgets/my_snackbar.dart';
import 'package:final_assignment/features/auth/domain/usecase/auth_usecase.dart';
import 'package:final_assignment/features/forgot_password/presentation/state/forgot_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final forgotPasswordViewModelProvider =
    StateNotifierProvider<ForgotPasswordViewModel, ForgotPasswordState>((ref) {
  return ForgotPasswordViewModel(
    authUseCase: ref.watch(authUseCaseProvider),
  );
});

class ForgotPasswordViewModel extends StateNotifier<ForgotPasswordState> {
  ForgotPasswordViewModel({
    required this.authUseCase,
  }) : super(ForgotPasswordState.initial());

  final AuthUseCase authUseCase;

  sendOtp(String phoneNumber) async {
    state = state.copyWith(isLoading: true);

    var data = await authUseCase.sendOtp(phoneNumber);
    data.fold(
      (l) {
        state = state.copyWith(isLoading: false, error: l.error);
        showMySnackBar(message: l.error);
      },
      (r) {
        state = state.copyWith(isLoading: false, isSent: true);
        showMySnackBar(
            message: 'OTP Sent Successfully', backgroundColor: Colors.green);
      },
    );
  }

  verifyOtp(String otp, String phoneNumber, String password) async {
    state = state.copyWith(isLoading: true);

    var data = await authUseCase.resetPass(
      phoneNumber: phoneNumber,
      password: password,
      otp: otp,
    );
    data.fold(
      (l) {
        state = state.copyWith(isLoading: false, error: l.error);
      },
      (r) {
        state = state.copyWith(isLoading: false, isSent: false);

        showMySnackBar(
            message: 'Password Changed Successfully',
            backgroundColor: Colors.green);
      },
    );
  }
}
