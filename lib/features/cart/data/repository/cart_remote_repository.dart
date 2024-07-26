import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/cart/data/data_source/remote/cart_remote_data_source.dart';
import 'package:final_assignment/features/cart/domain/entity/cart_entity.dart';
import 'package:final_assignment/features/cart/domain/repository/cart_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cartRemoteRepositoryProvider = Provider<CartRemoteRepository>((ref) {
  final cartRemoteDataSource = ref.watch(cartRemoteDataSourceProvider);
  return CartRemoteRepository(cartRemoteDataSource: cartRemoteDataSource);
});

class CartRemoteRepository implements ICartRepository {
  final CartRemoteDataSource cartRemoteDataSource;

  CartRemoteRepository({required this.cartRemoteDataSource});

  @override
  Future<Either<Failure, List<CartEntity>>> getCarts() {
    return cartRemoteDataSource.getCarts();
  }

  @override
  Future<Either<Failure, bool>> addCart(String productId, int quantity) {
    return cartRemoteDataSource.addToCart(
        productId: productId, quantity: quantity);
  }

  @override
  Future<Either<Failure, bool>> updateCart(String productId, int quantity) {
    return cartRemoteDataSource.updateCart(
        productId: productId, quantity: quantity);
  }

  @override
  Future<Either<Failure, bool>> deleteCart(String id) {
    return cartRemoteDataSource.deleteFromCart(id: id);
  }
}
