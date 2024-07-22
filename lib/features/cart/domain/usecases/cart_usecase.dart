import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/cart/domain/entity/cart_entity.dart';
import 'package:final_assignment/features/cart/domain/repository/cart_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cartUsecaseProvider = Provider<CartUsecase>((ref) {
  final cartRepository = ref.watch(cartRepositoryProvider);
  return CartUsecase(cartRepository: cartRepository);
});

class CartUsecase{
  final ICartRepository cartRepository;

  CartUsecase({required this.cartRepository});

  Future<Either<Failure, List<CartEntity>>> getCarts() async {
    return cartRepository.getCarts();
  }
}