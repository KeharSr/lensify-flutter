import 'package:final_assignment/features/ratingandreview/data/model/rating_review_api_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reviews_dto.g.dart';

@JsonSerializable()
class ReviewsDto {
  final bool success;
  final String message;
  final List<RatingReviewApiModel> reviews;

  ReviewsDto({
    required this.success,
    required this.message,
    required this.reviews,
  });

  factory ReviewsDto.fromJson(Map<String, dynamic> json) =>
      _$ReviewsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewsDtoToJson(this);
}
