import 'package:final_assignment/features/place_order/data/model/place_order_api_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'place_order_dto.g.dart';

@JsonSerializable()
class PlaceOrderDto {
  final bool success;
  final String message;
  final List<PlaceOrderApiModel> orders;

  PlaceOrderDto({
    required this.success,
    required this.message,
    required this.orders,
  });

  factory PlaceOrderDto.fromJson(Map<String, dynamic> json) =>
      _$PlaceOrderDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceOrderDtoToJson(this);
}
