import 'package:final_assignment/features/cart/data/model/cart_api_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart_dto.g.dart';

@JsonSerializable()
class CartDto{
  final bool success;
  final String message;
  final List<CartApiModel> products;

   CartDto({
    required this.success,
    required this.message,
    required this.products,
  });

  factory CartDto.fromJson(Map<String, dynamic> json) => _$CartDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CartDtoToJson(this);
}