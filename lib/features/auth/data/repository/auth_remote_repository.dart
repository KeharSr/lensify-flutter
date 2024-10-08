import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/auth/data/data_source/remote/auth_remote_data_source.dart';
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:final_assignment/features/auth/domain/repository/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRemoteRepositoryProvider = Provider(
  (ref) => AuthRemoteRepository(
    ref.read(authRemoteDataSourceProvider),
  ),
);

class AuthRemoteRepository implements IAuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRemoteRepository(this._authRemoteDataSource);

  @override
  Future<Either<Failure, bool>> createUser(AuthEntity user) {
    return _authRemoteDataSource.createUser(user);
  }

  @override
  Future<Either<Failure, bool>> loginUser(String email, String password) {
    return _authRemoteDataSource.loginUser(email, password);
  }

  @override
  Future<Either<Failure, AuthEntity>> getCurrentUser() {
    return _authRemoteDataSource.getCurrentUser();
  }

  @override
  Future<Either<Failure, bool>> fingerPrintLogin(String id) {
    return _authRemoteDataSource.fingerPrintLogin(id);
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) {
    return _authRemoteDataSource.uploadProfilePicture(file);
  }

  @override
  Future<Either<Failure, bool>> updateUser(AuthEntity user) {
    return _authRemoteDataSource.updateUser(user);
  }

  @override
  Future<Either<Failure, bool>> sendOtp(String phoneNumber) {
    return _authRemoteDataSource.sentOtp(phoneNumber);
  }

  @override
  Future<Either<Failure, bool>> resetPass(
      {required String phoneNumber,
      required String password,
      required String otp}) {
    return _authRemoteDataSource.resetPassword(
        phoneNumber: phoneNumber, password: password, otp: otp);
  }

  @override
  Future<Either<Failure, AuthEntity>> getUserByGoogle(String token) {
    return _authRemoteDataSource.getGoogleUser(token);
  }

  @override
  Future<Either<Failure, bool>> googleLogin(String token, String? password) {
    return _authRemoteDataSource.googleLogin(token, password);
  }
}
