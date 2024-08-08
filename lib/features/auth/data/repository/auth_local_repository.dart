import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/auth/data/data_source/local/auth_local_data_source.dart';
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:final_assignment/features/auth/domain/repository/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authLocalRepositoryProvider = Provider<IAuthRepository>((ref) {
  return AuthLocalRepository(
    ref.read(authLocalDataSourceProvider),
  );
});

class AuthLocalRepository implements IAuthRepository {
  final AuthLocalDataSource _authLocalDataSource;

  AuthLocalRepository(this._authLocalDataSource);

  @override
  Future<Either<Failure, bool>> loginUser(String email, String password) {
    return _authLocalDataSource.loginUser(email, password);
  }

  @override
  Future<Either<Failure, bool>> createUser(AuthEntity user) {
    return _authLocalDataSource.createUser(user);
  }

  @override
  Future<Either<Failure, AuthEntity>> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> fingerPrintLogin(String id) {
    // TODO: implement fingerPrintLogin
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) {
    // TODO: implement uploadProfilePicture
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> updateUser(AuthEntity user) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> sendOtp(String phoneNumber) {
    // TODO: implement sendOtp
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> resetPass(
      {required String phoneNumber,
      required String password,
      required String otp}) {
    // TODO: implement resetPass
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, AuthEntity>> getUserByGoogle(String token) {
    // TODO: implement getUserByGoogle
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> googleLogin(String token, String? password) {
    // TODO: implement googleLogin
    throw UnimplementedError();
  }
}
