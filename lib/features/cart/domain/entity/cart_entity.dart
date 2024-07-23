import 'package:equatable/equatable.dart';
import 'package:final_assignment/features/product/domain/entity/product_entity.dart';

class CartEntity extends Equatable {
  final String? id;
  final String? userId;
  final ProductEntity? productId;
  final int quantity;
  final String status;

  const CartEntity({
    required this.id,
    required this.userId,
    required this.productId,
    required this.quantity,
    required this.status,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        productId,
        quantity,
        status,
      ];
}
