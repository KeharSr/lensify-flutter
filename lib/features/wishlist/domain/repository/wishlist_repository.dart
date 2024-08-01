import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/wishlist/data/repository/wishlist_remote_repository.dart';
import 'package:final_assignment/features/wishlist/domain/entity/wishlist_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final wishlistRepositoryProvider = Provider<IWishlistRepository>(
    (ref) => ref.read(wishlistRemoteRepositoryProvider));

abstract class IWishlistRepository {
  Future<Either<Failure, List<WishlistEntity>>> getWishlist();

  Future<Either<Failure, bool>> addWishlist(String productId);

  Future<Either<Failure, bool>> removeWishlist(String id);
}
