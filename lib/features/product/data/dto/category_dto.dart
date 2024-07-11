import 'package:final_assignment/features/product/data/model/product_api_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_dto.g.dart';

@JsonSerializable()
class CategoryDto {
  final bool success;
  final String message;
  final List<ProductApiModel> products;

  CategoryDto({
    required this.success,
    required this.message,
    required this.products,
  });

  factory CategoryDto.fromJson(Map<String, dynamic> json) =>
      _$CategoryDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryDtoToJson(this);
}
