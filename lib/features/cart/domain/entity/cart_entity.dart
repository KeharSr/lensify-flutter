import 'package:equatable/equatable.dart';

class CartEntity extends Equatable {
  final String? id;
  final String? userId;
  final String? productId;
  final int quantity;

  const CartEntity({
    required this.id,
    required this.userId,
    required this.productId,
    required this.quantity,
  });

  

  @override
  List<Object?> get props => [id, userId, productId, quantity];
}