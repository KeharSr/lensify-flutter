

import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/common/failure/failure.dart';
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:final_assignment/features/auth/domain/repository/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authUseCaseProvider = Provider((ref) {
  return AuthUseCase(ref.read(authRepositoryProvider));
});

class AuthUseCase {
  final IAuthRepository _authRepository;

  AuthUseCase(this._authRepository);

  
  Future<Either<Failure, bool>> createUser(AuthEntity user) async {
    return await _authRepository.createUser(user);
  }

  Future<Either<Failure, bool>> loginUser(
      String email, String password) async {
    return await _authRepository.loginUser(email, password);
  }

  Future<Either<Failure, AuthEntity>> getCurrentUser() async {
    return await _authRepository.getCurrentUser();
  }
}
