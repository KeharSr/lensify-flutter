import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class CartApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String? userId;
  final String? productId;
  final int quantity;

  const CartApiModel({
    required this.id,
    required this.userId,
    required this.productId,
    required this.quantity,
  });

  const CartApiModel.empty()
      : id = '',
        userId = '',
        productId = '',
        quantity = 0;

  factory CartApiModel.fromJson(Map<String, dynamic> json) =>
      _$CartApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartApiModelToJson(this);

  // To Entity
  CartApiModel toEntity() {
    return CartApiModel(
      id: id,
      userId: userId,
      productId: productId,
      quantity: quantity,
    );
  }

  // Covert Entity to Api Object
  factory CartApiModel.fromEntity(CartApiModel entity) {
    return CartApiModel(
      id: entity.id,
      userId: entity.userId,
      productId: entity.productId,
      quantity: entity.quantity,
    );
  }

  //Convert Api List to Entity List
  List<CartEntity> toEntityList(List<CartApiModel> carts) {
    return carts.map((cart) => cart.toEntity()).toList();
  }

  //Convert Entity List to Api List
  List<CartApiModel> fromEntityList(List<CartEntity> carts) {
    return carts.map((cart) => CartApiModel.fromEntity(cart)).toList();
  }

  @override
  List<Object?> get props => [id, userId, productId, quantity];
}
