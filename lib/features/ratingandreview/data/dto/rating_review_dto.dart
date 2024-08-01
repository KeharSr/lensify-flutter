import 'package:final_assignment/features/ratingandreview/data/model/rating_review_api_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rating_review_dto.g.dart';

@JsonSerializable()
class RatingReviewDto {
  final bool success;
  final String message;
  final List<RatingReviewApiModel> review;

  RatingReviewDto({
    required this.success,
    required this.message,
    required this.review,
  });

  factory RatingReviewDto.fromJson(Map<String, dynamic> json) =>
      _$RatingReviewDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RatingReviewDtoToJson(this);
}
