import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/product/data/repository/product_remote_repository.dart';
import 'package:final_assignment/features/product/domain/entity/product_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productRepositoryProvider =
    Provider<IProductRepository>((ref) => ref.read(productRemoteRepository));

abstract class IProductRepository {
  Future<Either<Failure, List<ProductEntity>>> pagination(int page, int limit);

  Future<Either<Failure, List<ProductEntity>>> getProductsByCategory(
      int page, int limit, String category);
}
