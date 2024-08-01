import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:final_assignment/app/constants/api_endpoint.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/core/networking/remote/http_service.dart';
import 'package:final_assignment/core/shared_prefs/user_shared_prefs.dart';
import 'package:final_assignment/features/cart/data/dto/cart_dto.dart';
import 'package:final_assignment/features/cart/data/model/cart_api_model.dart';
import 'package:final_assignment/features/cart/domain/entity/cart_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cartRemoteDataSourceProvider = Provider<CartRemoteDataSource>((ref) {
  final dio = ref.watch(httpServiceProvider);
  final cartApiModel = ref.watch(cartApiModelProvider);
  final userSharedPrefs = ref.watch(userSharedPrefsProvider);
  return CartRemoteDataSource(
    dio: dio,
    cartApiModel: cartApiModel,
    userSharedPrefs: userSharedPrefs,
  );
});

class CartRemoteDataSource {
  final Dio dio;
  final CartApiModel cartApiModel;
  final UserSharedPrefs userSharedPrefs;

  CartRemoteDataSource({
    required this.dio,
    required this.cartApiModel,
    required this.userSharedPrefs,
  });

  // get cart
  Future<Either<Failure, List<CartEntity>>> getCarts() async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r,
      );

      print('Token: $token');
      var response = await dio.get(
        ApiEndpoints.getCart,
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );

      print('Response status code: ${response.statusCode}');
      print('Response data: ${response.data}');

      if (response.statusCode == 200) {
        final cartDto = CartDto.fromJson(response.data);

        return Right(cartApiModel.toEntityList(cartDto.products));
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
          error: e.message.toString(),
        ),
      );
    }
  }


  Future<Either<Failure, bool>> addToCart({
    required String productId,
    required int quantity,
  }) async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r,
      );

      print('Token: $token');
      var response = await dio.post(
        ApiEndpoints.addToCart,
        data: {
          'productId': productId,
          'quantity': quantity,
        },
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );

      print('Response status code: ${response.statusCode}');
      print('Response data: ${response.data}');

      if (response.statusCode == 201) {
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
          error: e.message.toString(),
        ),
      );
    }
  }

  // update cart
  Future<Either<Failure, bool>> updateCart({
    required String productId,
    required int quantity,
  }) async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r,
      );

      print('Token: $token');
      var response = await dio.put(
        ApiEndpoints.updateCart,
        data: {
          'productId': productId,
          'quantity': quantity,
        },
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );

      print('Response status code: ${response.statusCode}');
      print('Response data: ${response.data}');

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
          error: e.message.toString(),
        ),
      );
    }
  }

  // delete from cart
  Future<Either<Failure, bool>> deleteFromCart({
    required String id,
  }) async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r,
      );

      print('Token: $token');
      var response = await dio.delete(
        '${ApiEndpoints.deleteCart}/$id',
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );

      print('Response status code: ${response.statusCode}');
      print('Response data: ${response.data}');

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
          error: e.message.toString(),
        ),
      );
    }
  }
}
