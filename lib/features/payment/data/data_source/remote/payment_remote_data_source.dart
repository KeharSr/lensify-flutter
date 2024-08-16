import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:final_assignment/app/constants/api_endpoint.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/core/networking/remote/http_service.dart';
import 'package:final_assignment/core/shared_prefs/user_shared_prefs.dart';
import 'package:final_assignment/features/payment/data/model/payment_api_model.dart';
import 'package:final_assignment/features/payment/domain/entity/payment_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider for the data source
final paymentRemoteDataSourceProvider = Provider(
  (ref) => PaymentRemoteDataSource(
    dio: ref.watch(httpServiceProvider),
    userSharedPrefs: ref.watch(userSharedPrefsProvider),
  ),
);

class PaymentRemoteDataSource {
  final Dio dio;
  final UserSharedPrefs userSharedPrefs;

  PaymentRemoteDataSource({
    required this.dio,
    required this.userSharedPrefs,
  });

  // Initialize Khalti payment
  Future<Either<Failure, String>> initializeKhaltiPayment({
    required String orderId,
    required double totalPrice,
  }) async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold((l) => null, (r) => token = r);

      var response = await dio.post(
        ApiEndpoints.initlizePayment,
        data: {
          "orderId": orderId,
          "totalPrice": totalPrice,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      if (response.statusCode == 200) {
        return Right(response.data['pidx']);
      } else {
        return Left(Failure(
          error: response.data['message'] ?? 'Failed to initialize payment',
          statusCode: response.statusCode.toString(),
        ));
      }
    } on DioException catch (e) {
      return Left(Failure(
        error: e.message.toString(),
      ));
    }
  }

  // Verify Khalti payment
  Future<Either<Failure, String>> verifyKhaltiPayment(
      PaymentEntity entity) async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold((l) => null, (r) => token = r);

      var response = await dio.get(ApiEndpoints.verifyPayment,
          queryParameters: PaymentApiModel.fromEntity(entity).toJson());
      Options(
        headers: {
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200 && response.data['success']) {
        return Right(response.data['transactionId']
            .toString()); // Payment verified successfully
      } else {
        return Left(Failure(
          error: response.data['message'] ?? 'Failed to verify payment',
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
