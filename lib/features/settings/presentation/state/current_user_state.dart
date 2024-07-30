import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';

class CurrentUserState {
  final bool isLoading;
  final AuthEntity? authEntity;
  final String? error;
  final bool isFingerprintEnabled;
  final String uploadProfilePicture;

  CurrentUserState(
      {required this.isLoading,
      required this.authEntity,
      required this.error,
      required this.isFingerprintEnabled,
      required this.uploadProfilePicture});

  factory CurrentUserState.initial() {
    return CurrentUserState(
        isLoading: false,
        authEntity: null,
        error: null,
        isFingerprintEnabled: false,
        uploadProfilePicture: '');
  }

  CurrentUserState copyWith(
      {bool? isLoading,
      AuthEntity? authEntity,
      String? error,
      bool? isFingerprintEnabled,
      String? uploadProfilePicture}) {
    return CurrentUserState(
        isLoading: isLoading ?? this.isLoading,
        authEntity: authEntity ?? this.authEntity,
        error: error ?? this.error,
        isFingerprintEnabled: isFingerprintEnabled ?? this.isFingerprintEnabled,
        uploadProfilePicture:
            uploadProfilePicture ?? this.uploadProfilePicture);
  }
}
