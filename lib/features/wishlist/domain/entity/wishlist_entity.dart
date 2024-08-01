import 'package:equatable/equatable.dart';
import 'package:final_assignment/features/product/domain/entity/product_entity.dart';

class WishlistEntity extends Equatable {
  final String? id;
  final String? userId;
  final ProductEntity? productId;

  WishlistEntity(
      {required this.id, required this.userId, required this.productId});

  @override
  List<Object?> get props => [id, userId, productId];
}
