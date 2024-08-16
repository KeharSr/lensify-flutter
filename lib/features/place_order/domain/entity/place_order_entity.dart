import 'package:equatable/equatable.dart';
import 'package:final_assignment/features/cart/domain/entity/cart_entity.dart';

class PlaceOrderEntity extends Equatable {
  final String? id;
  final String? userId;
  final List<CartEntity>? carts;
  final num totalPrice;
  final String name;
  final String email;
  final String street;
  final String city;
  final String state;
  final String zipCode;
  final String country;
  final String phone;
  final String status;
  final bool payment;
  final String paymentMethod;

  const PlaceOrderEntity({
    this.id,
    this.userId,
    required this.carts,
    required this.totalPrice,
    required this.status,
    required this.payment,
    required this.paymentMethod,
    required this.name,
    required this.email,
    required this.street,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.country,
    required this.phone,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        carts,
        totalPrice,
        status,
        payment,
        paymentMethod,
        name,
        email,
        street,
        city,
        state,
        zipCode,
        country,
        phone,
      ];
}
