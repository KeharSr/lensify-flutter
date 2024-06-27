
import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/common/failure/failure.dart';
import 'package:final_assignment/features/home/domain/entity/product_entity.dart';

abstract class IProductRepository {
  Future<Either<Failure,ProductEntity>> getProducts();
}