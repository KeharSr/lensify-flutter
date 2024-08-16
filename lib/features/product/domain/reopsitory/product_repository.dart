import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/product/data/repository/product_remote_repository.dart';
import 'package:final_assignment/features/product/domain/entity/product_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/common/provider/internet_connectivity.dart';
import '../../data/repository/product_local_repository.dart';

final productRepositoryProvider = Provider<IProductRepository>((ref) {
  final checkConnectivity = ref.watch(connectivityStatusProvider);

  if (checkConnectivity == ConnectivityStatus.isConnected) {
    return ref.watch(productRemoteRepository);
  } else {
    return ref.watch(productLocalRepositoryProvider);
  }
});

abstract class IProductRepository {
  Future<Either<Failure, List<ProductEntity>>> getProductsByCategory(
      int page, int limit, String category, String search);

  Future<Either<Failure, ProductEntity>> getProductById(String id);

  Future<Either<Failure, List<ProductEntity>>> searchProduct(String query);

  Future<Either<Failure, List<ProductEntity>>> getProductFromHive();

  Future<Either<Failure, bool>> addProductsToHive(List<ProductEntity> products);
}
