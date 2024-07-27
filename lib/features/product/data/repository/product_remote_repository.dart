import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/product/data/data_source/remote/product_remote_data_source.dart';
import 'package:final_assignment/features/product/domain/entity/product_entity.dart';
import 'package:final_assignment/features/product/domain/reopsitory/product_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productRemoteRepository = Provider<IProductRepository>((ref) {
  final productRemoteDataSource = ref.watch(productRemoteDataSourceProvider);
  return ProductRemoteRepository(
      productRemoteDataSource: productRemoteDataSource);
});

class ProductRemoteRepository implements IProductRepository {
  final ProductRemoteDataSource productRemoteDataSource;

  ProductRemoteRepository({required this.productRemoteDataSource});

  @override
  Future<Either<Failure, List<ProductEntity>>> getProductsByCategory(
      int page, int limit, String category) {
    return productRemoteDataSource.getProductsByCategory(
        page: page, limit: limit, category: category);
  }

  // get single product
  @override
  Future<Either<Failure, ProductEntity>> getProductById(String id) {
    return productRemoteDataSource.getSingleProduct(id);
  }
}
