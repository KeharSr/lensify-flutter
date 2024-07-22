import 'package:equatable/equatable.dart';

class CartEntity extends Equatable {
  final String? id;
  final String userId;
  final String productId;
  final int quantity;
  final String productName;
  final String productImage;
  final int productPrice;
  final String productDescription;


  const CartEntity({
    required this.id,
    required this.userId,
    required this.productId,
    required this.quantity,
    required this.productName,
    required this.productImage,
    required this.productPrice,
    required this.productDescription,
  });

  

  @override
  List<Object?> get props => [id, userId, productId, quantity];
}