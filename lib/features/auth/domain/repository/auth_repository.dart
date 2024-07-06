import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/common/provider/internet_connectivity.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/auth/data/repository/auth_local_repository.dart';
import 'package:final_assignment/features/auth/data/repository/auth_remote_repository.dart';
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider<IAuthRepository>((ref) {
  final checkConnectivity = ref.read(connectivityStatusProvider);

  if (checkConnectivity == ConnectivityStatus.isDisconnected) {
    return ref.read(authLocalRepositoryProvider);
  } else {
    return ref.read(authRemoteRepositoryProvider);
  }
});

abstract class IAuthRepository {
  Future<Either<Failure, bool>> createUser(AuthEntity user);

  Future<Either<Failure, bool>> loginUser(String email, String password);

  Future<Either<Failure, AuthEntity>> getCurrentUser();

  Future<Either<Failure, bool>> fingerPrintLogin(String id);
}
