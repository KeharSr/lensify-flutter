import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:final_assignment/app/constants/api_endpoint.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/core/networking/remote/http_service.dart';
import 'package:final_assignment/core/shared_prefs/user_shared_prefs.dart';
import 'package:final_assignment/features/wishlist/data/dto/wishlist_dto.dart';
import 'package:final_assignment/features/wishlist/data/model/wishlist_api_model.dart';
import 'package:final_assignment/features/wishlist/domain/entity/wishlist_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final wishlistRemoteDataSourceProvider = Provider(
  (ref) => WishlistRemoteDataSource(
      dio: ref.read(httpServiceProvider),
      userSharedPrefs: ref.read(userSharedPrefsProvider),
      wishlistApiModel: ref.read(wishlistApiModelProvider)),
);

class WishlistRemoteDataSource {
  final Dio dio;
  final UserSharedPrefs userSharedPrefs;
  final WishlistApiModel wishlistApiModel;

  WishlistRemoteDataSource(
      {required this.dio,
      required this.userSharedPrefs,
      required this.wishlistApiModel});

// Get Wishlist
  Future<Either<Failure, List<WishlistEntity>>> getWishlist() async {
    try {
      String? token;
      final data = await userSharedPrefs.getUserToken();
      data.fold((l) => null, (r) => token = r);
      print('Token: $token');

      var response = await dio.get(
        ApiEndpoints.getFavourite,
        options: Options(
          headers: {
            'authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        final wishlistDto = WishlistDto.fromJson(response.data);
        return Right(wishlistApiModel.toEntityList(wishlistDto.favorites));
      } else {
        return Left(Failure(
          error: response.data['message'],
          statusCode: response.statusCode.toString(),
        ));
      }
    } on DioException catch (e) {
      return Left(Failure(error: e.message.toString()));
    }
  }

// Future<Either<Failure, List<WishlistEntity>>> getWishlist() async {
//   try {
//     String? token;
//     final data = await userSharedPrefs.getUserToken();
//     data.fold((l) => null, (r) => token = r);
//     print('Token: $token');
//
//     if (token == null) {
//       return Left(Failure(error: 'Token is null'));
//     }
//
//     var response = await dio.get(
//       ApiEndpoints.getFavourite,
//       options: Options(
//         headers: {
//           'authorization': 'Bearer $token',
//         },
//       ),
//     );
//
//     if (response.statusCode == 200) {
//       print('Response Data: ${response.data}');
//       if (response.data is Map<String, dynamic> &&
//           response.data['favourites'] != null) {
//         final wishlistDto = WishlistDto.fromJson(response.data);
//         return Right(wishlistApiModel.toEntityList(wishlistDto.favorites));
//       } else {
//         return Left(Failure(
//           error: 'Unexpected response format',
//           statusCode: response.statusCode.toString(),
//         ));
//       }
//     } else {
//       return Left(Failure(
//         error: response.data['message'] ?? 'Unknown error',
//         statusCode: response.statusCode.toString(),
//       ));
//     }
//   } on DioException catch (e) {
//     return Left(Failure(error: 'DioException: ${e.message}'));
//   } catch (e) {
//     return Left(Failure(error: 'Unknown error: ${e.toString()}'));
//   }
// }
}
