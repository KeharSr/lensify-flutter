import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:final_assignment/app/constants/api_endpoint.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/core/networking/remote/http_service.dart';
import 'package:final_assignment/core/shared_prefs/user_shared_prefs.dart';
import 'package:final_assignment/features/place_order/data/model/place_order_api_model.dart';
import 'package:final_assignment/features/place_order/domain/entity/place_order_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//provider
final placeOrderRemoteDataSourceProvider = Provider(
  (ref) => PlaceOrderRemoteDataSource(
    dio: ref.watch(httpServiceProvider),
    userSharedPrefs: ref.watch(userSharedPrefsProvider),
    placeOrderApiModel: ref.watch(placeOrderApiModelProvider),
  ),
);

class PlaceOrderRemoteDataSource {
  final Dio dio;
  final UserSharedPrefs userSharedPrefs;
  final PlaceOrderApiModel placeOrderApiModel;

  PlaceOrderRemoteDataSource(
      {required this.dio,
      required this.userSharedPrefs,
      required this.placeOrderApiModel});

  Future<Either<Failure, String>> placeOrder(entity) async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold((l) => null, (r) => token = r);

      print('Token: $token');

      var response = await dio.post(
        ApiEndpoints.placeOrder,
        data: PlaceOrderApiModel.fromEntity(entity).toJson(),
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );

      print('Place Order Response: ${response.data}');
      print('Response data: ${response.data}');

      if (response.statusCode == 201) {
        return Right(response.data['order_id']);
      } else {
        return Left(Failure(
          error: response.data['message'],
          statusCode: response.statusCode.toString(),
        ));
      }
    } on DioException catch (e) {
      return Left(Failure(
        error: e.message.toString(),
      ));
    }
  }

  // get order by user
  Future<Either<Failure, List<PlaceOrderEntity>>> getOrderByUser() async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold((l) => null, (r) => token = r);

      print('Token: $token');

      var response = await dio.get(
        ApiEndpoints.getOrders,
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );

      print('Get Order By User Response: ${response.data}');
      print('Response data: ${response.data}');

      if (response.statusCode == 200) {
        return Right(response.data['data']);
      } else {
        return Left(Failure(
          error: response.data['message'],
          statusCode: response.statusCode.toString(),
        ));
      }
    } on DioException catch (e) {
      return Left(Failure(
        error: e.message.toString(),
      ));
    }
  }
}
