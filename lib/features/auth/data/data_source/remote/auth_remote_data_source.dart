import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:final_assignment/app/constants/api_endpoint.dart';
import 'package:final_assignment/core/common/failure/failure.dart';
import 'package:final_assignment/core/common/shared_prefs/user_shared_prefs.dart';
import 'package:final_assignment/core/networking/remote/http_service.dart';
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRemoteDataSourceProvider = Provider(
  (ref) => AuthRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    userSharedPrefs: ref.read(userSharedPrefsProvider),
  ),
);

class AuthRemoteDataSource {
  final Dio dio;
  final UserSharedPrefs userSharedPrefs;

  AuthRemoteDataSource({required this.dio, required this.userSharedPrefs});

  Future<Either<Failure, bool>> createUser(AuthEntity register) async {
    try {
      Response response = await dio.post(
        ApiEndpoints.register,
        data: {
          "firstName": register.firstName,
          "lastName": register.lastName,
          "email": register.email,
          "phone": register.phone,
          "userName": register.userName,
          "password": register.password,
        },
      );
      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(Failure(
        error: e.toString(),
        statusCode: e.response?.statusCode.toString() ?? '0',
      ));
    }
  }
}
