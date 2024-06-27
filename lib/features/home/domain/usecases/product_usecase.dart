import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/common/failure/failure.dart';
import 'package:final_assignment/features/home/data/repository/product_remote_repository.dart';

import 'package:final_assignment/features/home/domain/entity/product_entity.dart';
import 'package:final_assignment/features/home/domain/repository/product_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productUsecaseProvider = Provider<ProductUsecase>((ref) {
  return ProductUsecase(
    productRepository: ref.read(productRepositoryProvider),
  );
});

class ProductUsecase {
  final IProductRepository productRepository;

  ProductUsecase({required this.productRepository});

  Future<Either<Failure, ProductEntity>> getProducts() async {
    return await productRepository.getProducts();
  }
}
