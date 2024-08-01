import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:final_assignment/app/constants/api_endpoint.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/core/networking/remote/http_service.dart';
import 'package:final_assignment/core/shared_prefs/user_shared_prefs.dart';
import 'package:final_assignment/features/ratingandreview/data/dto/rating_review_dto.dart';
import 'package:final_assignment/features/ratingandreview/data/model/rating_review_api_model.dart';
import 'package:final_assignment/features/ratingandreview/domain/entity/rating_review_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ratingReviewRemoteDataSourceProvider = Provider(
  (ref) => RatingReviewRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    userSharedPrefs: ref.read(userSharedPrefsProvider),
    ratingReviewApiModel: ref.read(ratingReviewApiModelProvider),
  ),
);

class RatingReviewRemoteDataSource {
  final Dio dio;
  final UserSharedPrefs userSharedPrefs;
  final RatingReviewApiModel ratingReviewApiModel;

  RatingReviewRemoteDataSource(
      {required this.dio,
      required this.userSharedPrefs,
      required this.ratingReviewApiModel});

  // getRatingAndReview
  Future<Either<Failure, List<RatingReviewEntity>>> getReviewRating() async {
    try {
      String? token;
      final data = await userSharedPrefs.getUserToken();
      data.fold((l) => null, (r) => token = r);

      var response = await dio.get(
        ApiEndpoints.getRatingReview,
        options: Options(
          headers: {
            'authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        final ratingReviewDto = RatingReviewDto.fromJson(response.data);
        return Right(ratingReviewApiModel.toEntityList(ratingReviewDto.review));
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
}
