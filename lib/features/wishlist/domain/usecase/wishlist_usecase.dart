import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/wishlist/domain/entity/wishlist_entity.dart';
import 'package:final_assignment/features/wishlist/domain/repository/wishlist_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final wishlistUseCaseProvider = Provider<WishlistUsecase>((ref) {
  final wishlistRepository = ref.watch(wishlistRepositoryProvider);
  return WishlistUsecase(wishlistRepository: wishlistRepository);
});

class WishlistUsecase {
  final IWishlistRepository wishlistRepository;

  WishlistUsecase({required this.wishlistRepository});

  Future<Either<Failure, List<WishlistEntity>>> getWishlist() async {
    return wishlistRepository.getWishlist();
  }

  Future<Either<Failure, bool>> addWishlist(String productId) async {
    return wishlistRepository.addWishlist(productId);
  }

  Future<Either<Failure, bool>> removeWishlist(String id) async {
    return wishlistRepository.removeWishlist(id);
  }
}
