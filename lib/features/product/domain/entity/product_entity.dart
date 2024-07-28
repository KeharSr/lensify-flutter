import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String? id;
  final String productName;
  final int productPrice;
  final String productImage;
  final String productDescription;
  final String productCategory;
  final int productQuantity;
  final int quantity;

  const ProductEntity({
    required this.id,
    required this.productName,
    required this.productPrice,
    required this.productImage,
    required this.productDescription,
    required this.productCategory,
    required this.productQuantity,
    this.quantity = 1,
  });

  @override
  List<Object?> get props => [
        id,
        productName,
        productPrice,
        productImage,
        productDescription,
        productCategory,
        productQuantity,
        quantity,
      ];
}
