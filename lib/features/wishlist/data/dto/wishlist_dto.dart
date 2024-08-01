import 'package:final_assignment/features/wishlist/data/model/wishlist_api_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'wishlist_dto.g.dart';

@JsonSerializable()
class WishlistDto {
  final bool success;
  final String message;
  final List<WishlistApiModel> favourites;

  WishlistDto(
      {required this.success, required this.message, required this.favourites});

  factory WishlistDto.fromJson(Map<String, dynamic> json) =>
      _$WishlistDtoFromJson(json);

  Map<String, dynamic> toJson() => _$WishlistDtoToJson(this);
}
