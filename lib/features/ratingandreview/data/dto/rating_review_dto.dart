import 'package:json_annotation/json_annotation.dart';

part 'rating_review_dto.g.dart';

@JsonSerializable()
class RatingReviewDto {
  final bool success;
  final String message;
  final double averageRating;
  final int count;
  final String productId;

  RatingReviewDto({
    required this.success,
    required this.message,
    required this.averageRating,
    required this.count,
    required this.productId,
  });

  factory RatingReviewDto.fromJson(Map<String, dynamic> json) =>
      _$RatingReviewDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RatingReviewDtoToJson(this);
}
