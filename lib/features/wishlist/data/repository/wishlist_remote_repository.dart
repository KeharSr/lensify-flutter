import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/wishlist/data/data_source/remote/wishlist_remote_data_source.dart';
import 'package:final_assignment/features/wishlist/domain/entity/wishlist_entity.dart';
import 'package:final_assignment/features/wishlist/domain/repository/wishlist_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final wishlistRemoteRepositoryProvider =
    Provider<WishlistRemoteRepository>((ref) {
  final wishlistRemoteDatasource = ref.watch(wishlistRemoteDataSourceProvider);
  return WishlistRemoteRepository(wishlistRemoteDatasource);
});

class WishlistRemoteRepository implements IWishlistRepository {
  final WishlistRemoteDataSource wishlistRemoteDatasource;

  WishlistRemoteRepository(this.wishlistRemoteDatasource);

  @override
  Future<Either<Failure, List<WishlistEntity>>> getWishlist() {
    return wishlistRemoteDatasource.getWishlist();
  }

  @override
  Future<Either<Failure, bool>> addWishlist(String productId) {
    return wishlistRemoteDatasource.addWishlist(productId);
  }

  @override
  Future<Either<Failure, bool>> removeWishlist(String id) {
    return wishlistRemoteDatasource.removeWishlist(id);
  }
}
