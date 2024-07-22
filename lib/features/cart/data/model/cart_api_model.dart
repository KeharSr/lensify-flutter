import 'package:equatable/equatable.dart';
import 'package:final_assignment/features/cart/domain/entity/cart_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart_api_model.g.dart';

//provider
final cartApiModelProvider =
    Provider<CartApiModel>((ref) => const CartApiModel.empty());

@JsonSerializable()
class CartApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String userId;
  final String productId;
  final int quantity;
  final String productName;
  final String productImage;
  final int productPrice;
  final String productDescription;

  const CartApiModel({
    required this.id,
    required this.userId,
    required this.productId,
    required this.quantity,
    required this.productName,
    required this.productImage,
    required this.productPrice,
    required this.productDescription,
  });

  const CartApiModel.empty()
      : id = '',
        userId = '',
        productId = '',
        quantity = 0,
        productName = '',
        productImage = '',
        productPrice = 0,
        productDescription = '';

  factory CartApiModel.fromJson(Map<String, dynamic> json) =>
      _$CartApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartApiModelToJson(this);

  // To Entity
  CartEntity toEntity() {
    return CartEntity(
        id: id,
        userId: userId,
        productId: productId,
        quantity: quantity,
        productName: productName,
        productImage: productImage,
        productPrice: productPrice,
        productDescription: productDescription
        );
  }

  // Covert Entity to Api Object
  factory CartApiModel.fromEntity(CartEntity entity) {
    return CartApiModel(
        id: entity.id,
        userId: entity.userId,
        productId: entity.productId,
        quantity: entity.quantity,
        productName: entity.productName,
        productImage: entity.productImage,
        productPrice: entity.productPrice,
        productDescription: entity.productDescription
        );
  }

  //Convert Api List to Entity List
  List<CartEntity> toEntityList(List<CartApiModel> carts) {
    return carts.map((cart) => cart.toEntity()).toList();
  }

  List<CartApiModel> fromEntityList(List<CartEntity> carts) {
    return carts.map((cart) => CartApiModel.fromEntity(cart)).toList();
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        productId,
        quantity,
        productName,
        productImage,
        productPrice,
        productDescription
      ];
}
