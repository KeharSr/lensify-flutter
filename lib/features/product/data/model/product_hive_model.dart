import 'package:final_assignment/app/constants/hive_table_constants.dart';
import 'package:final_assignment/features/product/domain/entity/product_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';

part 'product_hive_model.g.dart';

final productHiveModelProvider = Provider(
  (ref) => ProductHiveModel.empty(),
);

@HiveType(typeId: HiveTableConstant.productTableId)
class ProductHiveModel {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String productName;
  @HiveField(2)
  final int productPrice;
  @HiveField(3)
  final String productImage;
  @HiveField(4)
  final String productDescription;
  @HiveField(5)
  final String productCategory;
  @HiveField(6)
  final int productQuantity;
  @HiveField(7)
  final int quantity;

  ProductHiveModel(
      {required this.id,
      required this.productName,
      required this.productPrice,
      required this.productImage,
      required this.productDescription,
      required this.productCategory,
      required this.productQuantity,
      required this.quantity});

  ProductHiveModel.empty()
      : this(
          id: '',
          productName: '',
          productPrice: 0,
          productImage: '',
          productDescription: '',
          productCategory: '',
          productQuantity: 0,
          quantity: 0,
        );

  ProductHiveModel.fromEntity(ProductEntity entity)
      : this(
          id: entity.id,
          productName: entity.productName,
          productPrice: entity.productPrice,
          productImage: entity.productImage,
          productDescription: entity.productDescription,
          productCategory: entity.productCategory,
          productQuantity: entity.productQuantity,
          quantity: entity.quantity,
        );

  ProductEntity toEntity() => ProductEntity(
        id: id,
        productName: productName,
        productPrice: productPrice,
        productImage: productImage,
        productDescription: productDescription,
        productCategory: productCategory,
        productQuantity: productQuantity,
        quantity: quantity,
      );

//   list of entity
  static List<ProductEntity> toEntities(List<ProductHiveModel> models) {
    return models.map((model) => model.toEntity()).toList();
  }

//   list of hive model
  static List<ProductHiveModel> fromEntities(List<ProductEntity> entities) {
    return entities
        .map((entity) => ProductHiveModel.fromEntity(entity))
        .toList();
  }
}
