import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/product/domain/entity/product_entity.dart';
import 'package:final_assignment/features/product/domain/reopsitory/product_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productUsecaseProvider = Provider<ProductUsecase>((ref) {
  final productRepository = ref.watch(productRepositoryProvider);
  return ProductUsecase(productRepository: productRepository);
});

class ProductUsecase {
  final IProductRepository productRepository;

  ProductUsecase({required this.productRepository});

  Future<Either<Failure, List<ProductEntity>>> pagination(int page, int limit) {
    return productRepository.pagination(page, limit);
  }

  Future<Either<Failure, List<ProductEntity>>> getProductsByCategory(
      int page, int limit, String category) {
    return productRepository.getProductsByCategory(page, limit, category);
  }
}
