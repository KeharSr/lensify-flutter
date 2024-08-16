import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/networking/local/hive_service.dart';
import 'package:final_assignment/features/product/data/model/product_hive_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/failure/failure.dart';
import '../../../domain/entity/product_entity.dart';

final productLocalDataSouceProvider = Provider(
  (ref) => ProductLocalDataSouce(
    ref.read(hiveServiceProvider),
    ref.read(productHiveModelProvider),
  ),
);

class ProductLocalDataSouce {
  final HiveService _hiveService;
  final ProductHiveModel _productHiveModel;

  ProductLocalDataSouce(this._hiveService, this._productHiveModel);

//   add all entity to hive

  Future<Either<Failure, bool>> addProductsToHive(
      List<ProductEntity> products) async {
    try {
      final models = ProductHiveModel.fromEntities(products);
      await HiveService.addProducts(models);
      return const Right(true);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

//   get all entity from hive

  Future<Either<Failure, List<ProductEntity>>> getProductFromHive() async {
    try {
      final products = await _hiveService.getProducts();

      print(products);
      return Right(products.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
