import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:final_assignment/app/constants/api_endpoint.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/core/networking/remote/http_service.dart';
import 'package:final_assignment/core/shared_prefs/user_shared_prefs.dart';
import 'package:final_assignment/features/product/data/dto/category_dto.dart';
import 'package:final_assignment/features/product/data/model/product_api_model.dart';
import 'package:final_assignment/features/product/domain/entity/product_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productRemoteDataSourceProvider =
    Provider<ProductRemoteDataSource>((ref) {
  final dio = ref.watch(httpServiceProvider);
  final productApiModel = ref.watch(productApiModelProvider);
  final userSharedPrefs = ref.watch(userSharedPrefsProvider);
  return ProductRemoteDataSource(
    dio: dio,
    productApiModel: productApiModel,
    userSharedPrefs: userSharedPrefs,
  );
});

class ProductRemoteDataSource {
  final Dio dio;
  final ProductApiModel productApiModel;
  final UserSharedPrefs userSharedPrefs;

  ProductRemoteDataSource({
    required this.dio,
    required this.productApiModel,
    required this.userSharedPrefs,
  });

// get products by category

  Future<Either<Failure, List<ProductEntity>>> getProductsByCategory(
      {required String category, required int page, required int limit}) async {
    try {
      final token = await userSharedPrefs.getUserToken();
      token.fold((l) => throw Failure(error: l.error), (r) => r);

      final response = await dio.get(
        ApiEndpoints.getProductsByCategory,
        queryParameters: {
          'category': category,
          'page': page,
          'limit': limit,
        },
        options: Options(
          headers: {
            'authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 201) {
        final categoryDto = CategoryDto.fromJson(response.data);
        return Right(productApiModel.toEntityList(categoryDto.products));
      }

      return Left(Failure(
          error: response.data['message'],
          statusCode: response.statusCode.toString()));
    } on DioException catch (e) {
      return Left(Failure(error: e.error.toString()));
    }
  }

  Future<Either<Failure, ProductEntity>> getSingleProduct(
      String productId) async {
    try {
      final tokenResult = await userSharedPrefs.getUserToken();
      final token = tokenResult.fold(
        (failure) => null,
        (token) => token,
      );

      if (token == null) {
        return Left(Failure(error: 'Invalid token'));
      }

      final response = await dio.get(
        '${ApiEndpoints.getSingleProduct}/$productId',
        options: Options(
          headers: {
            'authorization': 'Bearer $token',
          },
        ),
      );

      print('Response status code: ${response.statusCode}');
      print('Response data: ${response.data}');

      if (response.statusCode == 200) {
        final product = ProductApiModel.fromJson(response.data['product']);
        return Right(product.toEntity());
      }

      return Left(Failure(
        error: response.data['message'] ?? 'Unexpected error',
        statusCode: response.statusCode.toString(),
      ));
    } on DioException catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
