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

  Future<Either<Failure, List<CartEntity>>> getCarts({
    required String userId,
    required String productId,
    required int quantity,
  }) async {
    try {
      final token = await userSharedPrefs.getUserToken();
      token.fold((l) => throw Failure(error: l.error), (r) => r);
      final response = await dio.get(
        ApiEndpoints.getCart,
        queryParameters: {
          'userId': userId,
          'productId': productId,
          'quantity': quantity,
        },
        options: Options(
          headers: {
            'authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 201) {
        final cartDto = CartDto.fromJson(response.data);
        return Right(cartApiModel.toEntityList(cartDto.carts));
      }
      return Left(Failure(
        error: response.statusCode.toString(),
      ));
    } on DioException catch (e) {
      return Left(Failure(error: e.error.toString()));
    }
  }
}
