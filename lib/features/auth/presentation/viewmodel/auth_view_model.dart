import 'package:final_assignment/core/common/widgets/my_snackbar.dart';
import 'package:final_assignment/core/google/google_service.dart';
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:final_assignment/features/auth/domain/usecase/auth_usecase.dart';
import 'package:final_assignment/features/auth/presentation/navigator/login_navigator.dart';
import 'package:final_assignment/features/auth/presentation/navigator/register_navigator.dart';
import 'package:final_assignment/features/auth/presentation/state/auth_state.dart';
import 'package:final_assignment/features/forgot_password/presentation/navigator/forgot_password_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';

final authViewModelProvider = StateNotifierProvider<AuthViewModel, AuthState>(
  (ref) => AuthViewModel(
      ref.read(loginViewNavigatorProvider),
      ref.read(registerViewNavigatorProvider),
      ref.read(authUseCaseProvider),
      ref.read(forgetPasswordViewNavigatorProvider),
      ref.watch(googleSignInServiceProvider)),
);

class AuthViewModel extends StateNotifier<AuthState> {
  AuthViewModel(this.navigator, this.registerNavigator, this.authUseCase,
      this.forgetPasswordNavigator, this.googleSignInService)
      : super(AuthState.initial());

  final AuthUseCase authUseCase;
  final LoginViewNavigator navigator;
  final RegisterViewNavigator registerNavigator;
  final ForgotPasswordViewNavigator forgetPasswordNavigator;
  late LocalAuthentication _localAuth;
  final GoogleSignInService googleSignInService;

  Future<void> createUser(AuthEntity user) async {
    state = state.copyWith(isLoading: true);
    var data = await authUseCase.createUser(user);
    data.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.error,
        );
        // showMySnackBar(message: failure.error, backgroundColor: Colors.red);
      },
      (success) {
        state = state.copyWith(isLoading: false, error: null);
        // showMySnackBar(message: "Successfully registered");
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
        print(failure.statusCode);
        state = state.copyWith(isLoading: false, error: failure.error);
        // showMySnackBar(message: failure.error, backgroundColor: Colors.red);
      },
      (success) {
        state = state.copyWith(isLoading: false, error: null);
        // showMySnackBar(message: "Successfully logged in");
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
        // showMySnackBar(message: failure.error, backgroundColor: Colors.red);
      },
      (success) {
        state = state.copyWith(isLoading: false, error: null);
        // showMySnackBar(message: "Successfully logged in");
        openHomeView();
      },
    );
  }

  Future<void> fingerPrintLogin() async {
    _localAuth = LocalAuthentication();

    bool authenticated = false;
    try {
      authenticated = await _localAuth.authenticate(
        localizedReason: 'Authenticate to enable fingerprint',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
          useErrorDialogs: true,
        ),
      );
    } catch (e) {
      // showMySnackBar(
      //     message: 'Fingerprint authentication failed',
      //     backgroundColor: Colors.red);
    }

    if (authenticated) {
      authUseCase.fingerPrintLogin().then((data) {
        data.fold(
          (l) {
            showMySnackBar(message: l.error, backgroundColor: Colors.red);
          },
          (r) {
            // showMySnackBar(message: "User logged in successfully");
            navigator.openHomeView();
          },
        );
      });
    } else {
      // showMySnackBar(
      //     message: 'Fingerprint authentication failed',
      //     backgroundColor: Colors.red);
    }
  }

  // google login
  googleLogin({required String token, String? password}) async {
    state = state.copyWith(isLoading: true);
    final data = await authUseCase.googleLogin(token, password);
    data.fold((l) {
      state = state.copyWith(isLoading: false, error: l.error);
      // showMySnackBar(message: l.error, textColor: Colors.red);
    }, (r) {
      state = state.copyWith(isLoading: false);
      openHomeView();
    });
  }

  //get google user
  getUserByGoogle() async {
    state = state.copyWith(isLoading: true);
    final google = await googleSignInService.signInWithGoogle();
    if (google != null) {
      final token = google['idToken'];
      print(token);
      final user = await authUseCase.getUserByGoogle(token);
      user.fold((l) {
        state = state.copyWith(isLoading: false, error: l.error);
      }, (r) {
        if (r.email.isEmpty) {
          googleLogin(token: token, password: '12345678');
        } else {
          googleLogin(token: token);
        }
        state = state.copyWith(isLoading: false);
      });
    } else {
      // showMySnackBar(message: 'Google sign in failed');
      state = state.copyWith(isLoading: false);
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

  void openForgotPasswordView() {
    navigator.openForgotPasswordView();
  }
}
