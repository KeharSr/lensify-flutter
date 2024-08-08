import 'dart:io';

import 'package:final_assignment/core/common/widgets/my_snackbar.dart';
import 'package:final_assignment/core/common/widgets/my_yes_no_dialog.dart';
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:final_assignment/features/auth/domain/usecase/auth_usecase.dart';
import 'package:final_assignment/features/settings/presentation/state/current_user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';

import '../../../../core/shared_prefs/user_shared_prefs.dart';

final currentUserViewModelProvider =
    StateNotifierProvider<CurrentUserViewModel, CurrentUserState>(
        (ref) => CurrentUserViewModel(
              authUseCase: ref.read(authUseCaseProvider),
              userSharedPrefs: ref.read(userSharedPrefsProvider),
            ));

class CurrentUserViewModel extends StateNotifier<CurrentUserState> {
  final AuthUseCase authUseCase;
  late LocalAuthentication _localAuth;
  final UserSharedPrefs userSharedPrefs;

  CurrentUserViewModel({
    required this.authUseCase,
    required this.userSharedPrefs,
  }) : super(CurrentUserState.initial()) {
    initialize();
  }

  Future<void> initialize() async {
    _localAuth = LocalAuthentication();
    await getCurrentUser();
    await checkFingerprint();
  }

  Future<void> getCurrentUser() async {
    try {
      state = state.copyWith(isLoading: true);
      final data = await authUseCase.getCurrentUser();
      data.fold(
        (l) {
          state = state.copyWith(isLoading: false, error: l.error);
        },
        (r) {
          if (r.profilePicture != null) {
            state = state.copyWith(
                isLoading: false,
                authEntity: r,
                uploadProfilePicture: r.profilePicture);
          } else {
            state = state.copyWith(isLoading: false, authEntity: r);
          }
        },
      );
    } catch (e) {
      state = state.copyWith(
          isLoading: false, error: 'Failed to fetch current user.');
      print('Error fetching current user: $e');
    }
  }

  Future<void> enableFingerprint() async {
    if (state.isFingerprintEnabled) {
      bool result = await myYesNoDialog(
        title: 'Are you sure? Do you want to disable fingerprint login?',
      );
      if (result) {
        state = state.copyWith(isFingerprintEnabled: false);
        userSharedPrefs.saveFingerPrintId('');
      }
    } else {
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
        showMySnackBar(
            message: 'Fingerprint authentication failed',
            backgroundColor: Colors.red);
      }

      if (authenticated) {
        state = state.copyWith(isFingerprintEnabled: true);
        userSharedPrefs.saveFingerPrintId(state.authEntity?.id ?? '');
        showMySnackBar(
            message: 'Fingerprint enabled', backgroundColor: Colors.green);
      }
    }
  }

  Future<void> checkFingerprint() async {
    final currentUserId = state.authEntity?.id;
    if (currentUserId == null) {
      state = state.copyWith(isFingerprintEnabled: false);
      return;
    }

    final result = await userSharedPrefs.checkId();
    result.fold(
      (l) {
        state = state.copyWith(isFingerprintEnabled: false);
      },
      (r) {
        if (r == currentUserId) {
          state = state.copyWith(isFingerprintEnabled: true);
        } else {
          state = state.copyWith(isFingerprintEnabled: false);
        }
      },
    );
  }

  Future<void> uploadProfilePicture(File file) async {
    state = state.copyWith(isLoading: true);
    final data = await authUseCase.uploadProfilePicture(file);
    data.fold(
      (l) {
        state = state.copyWith(isLoading: false, error: l.error);
      },
      (uploadProfilePicture) {
        state = state.copyWith(
            isLoading: false,
            error: null,
            uploadProfilePicture: uploadProfilePicture);
        showMySnackBar(
            message: 'Profile picture uploaded', backgroundColor: Colors.green);
      },
    );
  }

  Future<void> updateUser(AuthEntity user) async {
    state = state.copyWith(isLoading: true);
    final data = await authUseCase.updateUser(user);
    data.fold(
      (l) {
        state = state.copyWith(isLoading: false, error: l.error);
      },
      (r) {
        state = state.copyWith(isLoading: false, error: null);
        showMySnackBar(
            message: 'Profile updated', backgroundColor: Colors.green);
      },
    );
  }
}
