import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:final_assignment/app/constants/api_endpoint.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/core/networking/remote/http_service.dart';
import 'package:final_assignment/core/shared_prefs/user_shared_prefs.dart';
import 'package:final_assignment/features/auth/data/dto/get_current_user_dto.dart';
import 'package:final_assignment/features/auth/data/model/auth_api_model.dart';
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRemoteDataSourceProvider = Provider(
  (ref) => AuthRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    userSharedPrefs: ref.read(userSharedPrefsProvider),
    authApiModel: ref.read(authApiModelProvider),
  ),
);

class AuthRemoteDataSource {
  final Dio dio;
  final UserSharedPrefs userSharedPrefs;
  final AuthApiModel authApiModel;

  AuthRemoteDataSource({
    required this.dio,
    required this.userSharedPrefs,
    required this.authApiModel,
  });

  Future<Either<Failure, bool>> createUser(AuthEntity createUser) async {
    try {
      Response response = await dio.post(
        ApiEndpoints.createUser,
        data: authApiModel.fromEntity(createUser).toJson(),
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
        error: e.message.toString(),
      ));
    }
  }

  Future<Either<Failure, bool>> loginUser(
    String email,
    String password,
  ) async {
    try {
      Response response = await dio.post(
        ApiEndpoints.loginUser,
        data: {
          "email": email,
          "password": password,
        },
      );

      if (response.statusCode == 200) {
        final token = response.data['token'];
        await userSharedPrefs.setUserToken(token);
        return const Right(true);
      }

      return Left(
        Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString()),
      );
    } on DioException catch (e) {
      print(e);
      return Left(
        Failure(
          error: e.message.toString(),
        ),
      );
    }
  }

  // Get current user
  Future<Either<Failure, AuthEntity>> getCurrentUser() async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r,
      );

      print('Token: $token');
      var response = await dio.get(
        ApiEndpoints.currentUser,
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );

      print('Response status code: ${response.statusCode}');
      print('Response data: ${response.data}');

      if (response.statusCode == 200) {
        final getCurrentUserDto = GetCurrentUserDto.fromJson(response.data);

        return Right(getCurrentUserDto.user.toEntity());
      } else {
        return Left(
          Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
        ),
      );
    }
  }

  // fingerprint
  Future<Either<Failure, bool>> fingerPrintLogin(String id) async {
    try {
      Response response = await dio.post(
        ApiEndpoints.getToken,
        data: {'id': id},
      );
      if (response.statusCode == 200) {
        final token = response.data['token'];
        await userSharedPrefs.setUserToken(token);
        return const Right(true);
      }

      return Left(
        Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString()),
      );
    } on DioException catch (e) {
      return Left(Failure(error: e.message.toString()));
    }
  }

// upload profile image

  Future<Either<Failure, String>> uploadProfilePicture(File image) async {
    try {
      // Retrieve the token
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r,
      );

      if (token == null) {
        return Left(
          Failure(
            error: 'No token found',
          ),
        );
      }

      // Prepare the image file

      FormData formData = FormData.fromMap(
        {
          'profilePicture': await MultipartFile.fromFile(
            image.path,
          ),
        },
      );

      Response response = await dio.post(
        // ApiEndpoints.profileImage,
        ApiEndpoints.profileImage,
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        print(response.data);
        return Right(response.data["profilePicture"]);
      } else {
        return Left(
          Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString(),
        ),
      );
    }
  }

  // update user
  Future<Either<Failure, bool>> updateUser(AuthEntity updateUser) async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r,
      );

      if (token == null) {
        return Left(
          Failure(
            error: 'No token found',
          ),
        );
      }

      Response response = await dio.put(
        ApiEndpoints.updateUser,
        data: authApiModel.fromEntity(updateUser).toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
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
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  // sent otp
  Future<Either<Failure, bool>> sentOtp(String phoneNumber) async {
    try {
      Response response = await dio.post(
        ApiEndpoints.sentOtp,
        data: {
          "phoneNumber": phoneNumber,
        },
      );

      if (response.statusCode == 200) {
        return const Right(true);
      }

      return Left(
        Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString()),
      );
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.message.toString(),
        ),
      );
    }
  }

  // reset password from otp
  Future<Either<Failure, bool>> resetPassword(
      {required String phoneNumber,
      required String otp,
      required String password}) async {
    try {
      Response response = await dio.post(
        ApiEndpoints.verifyOtp,
        data: {
          "phoneNumber": phoneNumber,
          "otp": otp,
          "password": password,
        },
      );

      if (response.statusCode == 200) {
        return const Right(true);
      }

      return Left(
        Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString()),
      );
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.message.toString(),
        ),
      );
    }
  }

  Future<Either<Failure, bool>> googleLogin(
      String token, String? password) async {
    try {
      Response response = await dio.post(
        ApiEndpoints.googleLogin,
        data: {
          "token": token,
          "password": password,
        },
      );

      if (response.statusCode == 201) {
        final token = response.data['token'];
        await userSharedPrefs.setUserToken(token);
        return const Right(true);
      }

      return Left(
        Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString()),
      );
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.message.toString(),
        ),
      );
    }
  }

  // get google user
  Future<Either<Failure, AuthEntity>> getGoogleUser(String token) async {
    try {
      Response response = await dio.post(
        ApiEndpoints.getUserByGoogle,
        data: {'token': token},
      );
      if (response.statusCode == 200) {
        final authModel = AuthApiModel.fromJson(response.data['data']);

        return Right(authModel.toEntity());
      }
      if (response.statusCode == 201) {
        const authModel = AuthApiModel.empty();
        return Right(authModel.toEntity());
      }
      return Left(
        Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString()),
      );
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
