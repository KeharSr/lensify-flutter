import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/product/domain/entity/product_entity.dart';
import 'package:final_assignment/features/product/domain/reopsitory/product_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data_source/local/product_local_data_souce.dart';

final productLocalRepositoryProvider = Provider<IProductRepository>(
  (ref) => ProductLocalRepository(
    ref.read(productLocalDataSouceProvider),
  ),
);

class ProductLocalRepository implements IProductRepository {
  final ProductLocalDataSouce _productLocalDataSouce;

  ProductLocalRepository(this._productLocalDataSouce);

  @override
  Future<Either<Failure, ProductEntity>> getProductById(String id) {
    // TODO: implement getProductById
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProductsByCategory(
      int page, int limit, String category, String search) {
    return _productLocalDataSouce.getProductFromHive();
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> searchProduct(String query) {
    // TODO: implement searchProduct
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> addProductsToHive(
      List<ProductEntity> products) {
    return _productLocalDataSouce.addProductsToHive(products);
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProductFromHive() {
    return _productLocalDataSouce.getProductFromHive();
  }
}
