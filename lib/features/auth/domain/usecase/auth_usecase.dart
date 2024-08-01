import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/core/shared_prefs/user_shared_prefs.dart';
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:final_assignment/features/auth/domain/repository/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authUseCaseProvider = Provider<AuthUseCase>((ref) {
  return AuthUseCase(
    authRepository: ref.watch(authRepositoryProvider),
    userSharedPrefs: ref.watch(userSharedPrefsProvider),
  );
});

class AuthUseCase {
  final IAuthRepository authRepository;
  final UserSharedPrefs userSharedPrefs;

  AuthUseCase({required this.authRepository, required this.userSharedPrefs});

  Future<Either<Failure, bool>> createUser(AuthEntity? user) async {
    return await authRepository.createUser(user ?? const AuthEntity.empty());
  }

  Future<Either<Failure, bool>> loginUser(
      String? email, String? password) async {
    return await authRepository.loginUser(email ?? '', password ?? '');
  }

  Future<Either<Failure, AuthEntity>> getCurrentUser() async {
    return await authRepository.getCurrentUser();
  }

  Future<Either<Failure, bool>> fingerPrintLogin() async {
    final data = await userSharedPrefs.checkId();
    return data.fold((l) => Left(Failure(error: l.error)), (r) async {
      if (r != '') {
        await authRepository.fingerPrintLogin(r);
        return const Right(true);
      }
      return Left(Failure(error: 'No fingerprint id found'));
    });
  }

  //uploadProfilePicture
  Future<Either<Failure, String>> uploadProfilePicture(File file) async {
    return await authRepository.uploadProfilePicture(file);
  }

  //updateUser
  Future<Either<Failure, bool>> updateUser(AuthEntity user) async {
    return await authRepository.updateUser(user);
  }
}
