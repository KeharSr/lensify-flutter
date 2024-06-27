// import 'package:dartz/dartz.dart';
// import 'package:final_assignment/core/common/failure/failure.dart';
// import 'package:final_assignment/features/home/data/data_source/product_data_source.dart';

// import 'package:final_assignment/features/home/domain/entity/product_entity.dart';
// import 'package:final_assignment/features/home/domain/repository/product_repository.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// final productRepositoryProvider = Provider<IProductRepository>(
//   (ref) =>
//   ProductRemoteRepository(
//     productDataSourceProvider:ref.read(productDataSourceProvider),
//   );
// });

// class ProductReomteRepository implements IProductRepository {
//   final ProductDataSource productDataSourceProvider;

//   ProductRemoteRepository({required this.productDataSourceProvider});
  
  
//   @override
//   Future<Either<Failure, ProductEntity>> getProducts() {
//     return productDataSourceProvider.getProducts();
//   }
// }


import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/home/data/data_source/product_data_source.dart';
import 'package:final_assignment/features/home/domain/repository/product_repository.dart';
import 'package:final_assignment/features/pet/data/data_source/remote/pet_remote_data_source.dart';
import 'package:final_assignment/features/pet/domain/entity/pet_entity.dart';
import 'package:final_assignment/features/pet/domain/repository/i_pet_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productRemoteRepository = Provider<IProductRepository>((ref) {
  final productRemoteDataSource = ref.watch(productDataSourceProvider);
  return ProductRemoteRepository(productDataSource: productDataSourceProvider);
});

class ProductRemoteRepository implements IProductRepository {
  final ProductDataSource petRemoteDataSource;

  PetRemoteRepository({required this.petRemoteDataSource});

  @override
  Future<Either<Failure, List<PetEntity>>> pagination(int page, int limit) {
    return petRemoteDataSource.pagination(page: page, limit: limit);
  }
}
