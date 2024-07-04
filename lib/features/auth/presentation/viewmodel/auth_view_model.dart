// import 'package:final_assignment/core/common/widgets/my_snackbar.dart';
// import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
// import 'package:final_assignment/features/auth/domain/usecase/auth_usecase.dart';
// import 'package:final_assignment/features/auth/presentation/navigator/login_navigator.dart';
// import 'package:final_assignment/features/auth/presentation/navigator/register_navigator.dart';
// import 'package:final_assignment/features/auth/presentation/state/auth_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// final authViewModelProvider = StateNotifierProvider<AuthViewModel, AuthState>(
//   (ref) => AuthViewModel(
//     ref.read(loginViewNavigatorProvider),
//     ref.read(registerViewNavigatorProvider),
//     ref.read(authUseCaseProvider),
//   ),
// );
//
// class AuthViewModel extends StateNotifier<AuthState> {
//   AuthViewModel(this.navigator, this.registerNavigator, this.authUseCase)
//       : super(AuthState.initial());
//   final AuthUseCase authUseCase;
//   final LoginViewNavigator navigator;
//   final RegisterViewNavigator registerNavigator;
//
//   Future<void> createUser(AuthEntity user) async {
//     state = state.copyWith(isLoading: true);
//     var data = await authUseCase.createUser(user);
//     data.fold(
//       (failure) {
//         state = state.copyWith(
//           isLoading: false,
//           error: failure.error,
//         );
//         showMySnackBar(message: failure.error, color: Colors.red);
//       },
//       (success) {
//         state = state.copyWith(isLoading: false, error: null);
//         showMySnackBar(message: "Successfully registered");
//       },
//     );
//   }
//
//   Future<void> loginUser(
//     String email,
//     String password,
//   ) async {
//     state = state.copyWith(isLoading: true);
//     var data = await authUseCase.loginUser(email, password);
//     data.fold(
//       (failure) {
//         state = state.copyWith(isLoading: false, error: failure.error);
//         showMySnackBar(message: failure.error, color: Colors.red);
//       },
//       (success) {
//         state = state.copyWith(isLoading: false, error: null);
//         showMySnackBar(message: "Successfully logged in");
//         openHomeView();
//       },
//     );
//   }
//
//   void openRegisterView() {
//     navigator.openRegisterView();
//   }
//
//   void openLoginView() {
//     registerNavigator.openLoginView();
//   }
//
//   void openHomeView() {
//     navigator.openHomeView();
//   }
// }


import 'package:final_assignment/core/common/widgets/my_snackbar.dart';
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:final_assignment/features/auth/domain/usecase/auth_usecase.dart';
import 'package:final_assignment/features/auth/presentation/navigator/login_navigator.dart';
import 'package:final_assignment/features/auth/presentation/navigator/register_navigator.dart';
import 'package:final_assignment/features/auth/presentation/state/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';

final authViewModelProvider = StateNotifierProvider<AuthViewModel, AuthState>(
      (ref) => AuthViewModel(
    ref.read(loginViewNavigatorProvider),
    ref.read(registerViewNavigatorProvider),
    ref.read(authUseCaseProvider),

  ),
);

class AuthViewModel extends StateNotifier<AuthState> {
  AuthViewModel(this.navigator, this.registerNavigator, this.authUseCase)
      : super(AuthState.initial());

  final AuthUseCase authUseCase;
  final LoginViewNavigator navigator;
  final RegisterViewNavigator registerNavigator;
  final LocalAuthentication auth = LocalAuthentication();

  Future<void> createUser(AuthEntity user) async {
    state = state.copyWith(isLoading: true);
    var data = await authUseCase.createUser(user);
    data.fold(
          (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.error,
        );
        showMySnackBar(message: failure.error, color: Colors.red);
      },
          (success) {
        state = state.copyWith(isLoading: false, error: null);
        showMySnackBar(message: "Successfully registered");
      },
    );
  }

  Future<void> loginUser(
      String email,
      String password,
      ) async {
    state = state.copyWith(isLoading: true);
    var data = await authUseCase.loginUser(email, password);
    data.fold(
          (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        showMySnackBar(message: failure.error, color: Colors.red);
      },
          (success) {
        state = state.copyWith(isLoading: false, error: null);
        showMySnackBar(message: "Successfully logged in");
        openHomeView();
      },
    );
  }

  // get current user
  Future<void> getCurrentUser() async {
    state = state.copyWith(isLoading: true);
    var data = await authUseCase.getCurrentUser();
    data.fold(
          (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        showMySnackBar(message: failure.error, color: Colors.red);
      },
          (success) {
        state = state.copyWith(isLoading: false, error: null);
        showMySnackBar(message: "Successfully logged in");
        openHomeView();
      },
    );
  }

  // authenticate with biometrics
  Future<void> authenticateWithBiometrics() async {
    state = state.copyWith(isLoading: true);
    try {
      bool authenticated = await auth.authenticate(
        localizedReason: 'Please authenticate to proceed',
        // biometricOnly: true,

      );
      if (authenticated) {
        state = state.copyWith(isLoading: false, error: null);
        showMySnackBar(message: "Biometric authentication successful");
        openHomeView();
      } else {
        state = state.copyWith(isLoading: false, error: "Authentication failed");
        showMySnackBar(message: "Biometric authentication failed", color: Colors.red);
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      showMySnackBar(message: e.toString(), color: Colors.red);
      print('PlatformException: $e');
    }
  }







  void openRegisterView() {
    navigator.openRegisterView();
  }

  void openLoginView() {
    registerNavigator.openLoginView();
  }

  void openHomeView() {
    navigator.openHomeView();
  }


}
