import 'package:equatable/equatable.dart';
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:final_assignment/features/place_order/domain/entity/address_entity.dart';
import 'package:final_assignment/features/product/domain/entity/product_entity.dart';

class OrderEntity extends Equatable {
  final String? id;
  final AuthEntity? userId;
  final List<ProductEntity> products;
  final num totalPrice;
  final AddressEntity address;
  final String status;
  final bool payment;
  final String paymentMethod;
  final DateTime date;

  OrderEntity({
    required this.id,
    required this.userId,
    required this.products,
    required this.totalPrice,
    required this.address,
    required this.status,
    required this.payment,
    required this.paymentMethod,
    required this.date,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        products,
        totalPrice,
        address,
        status,
        payment,
        paymentMethod,
        date,
      ];
}
