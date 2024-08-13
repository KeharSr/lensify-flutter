import 'package:equatable/equatable.dart';
import 'package:final_assignment/features/place_order/domain/entity/place_order_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../cart/data/model/cart_api_model.dart';

part 'place_order_api_model.g.dart';

// Provider\
final placeOrderApiModelProvider =
    Provider<PlaceOrderApiModel>((ref) => const PlaceOrderApiModel.empty());

@JsonSerializable()
class PlaceOrderApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String? userId;
  final List<CartApiModel>? carts;
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

  const PlaceOrderApiModel({
    required this.id,
    required this.userId,
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

  const PlaceOrderApiModel.empty()
      : id = '',
        userId = '',
        carts = null,
        totalPrice = 0,
        status = '',
        payment = false,
        paymentMethod = '',
        name = '',
        email = '',
        street = '',
        city = '',
        state = '',
        zipCode = '',
        country = '',
        phone = '';

  factory PlaceOrderApiModel.fromJson(Map<String, dynamic> json) =>
      _$PlaceOrderApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceOrderApiModelToJson(this);

  // To Entity
  PlaceOrderEntity toEntity() {
    return PlaceOrderEntity(
      id: id,
      userId: userId,
      carts: carts?.map((e) => e.toEntity()).toList(),
      totalPrice: totalPrice,
      name: name,
      email: email,
      street: street,
      city: city,
      state: state,
      zipCode: zipCode,
      country: country,
      phone: phone,
      status: status,
      payment: payment,
      paymentMethod: paymentMethod,
    );
  }

  // From Entity
  factory PlaceOrderApiModel.fromEntity(PlaceOrderEntity entity) {
    return PlaceOrderApiModel(
      id: entity.id,
      userId: entity.userId,
      carts: entity.carts
          ?.map(
            (e) => CartApiModel.fromEntity(e),
          )
          .toList(),
      totalPrice: entity.totalPrice,
      name: entity.name,
      email: entity.email,
      street: entity.street,
      city: entity.city,
      state: entity.state,
      zipCode: entity.zipCode,
      country: entity.country,
      phone: entity.phone,
      status: entity.status,
      payment: entity.payment,
      paymentMethod: entity.paymentMethod,
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        carts,
        totalPrice,
        name,
        email,
        street,
        city,
        state,
        zipCode,
        country,
        phone,
        status,
        payment,
        paymentMethod,
      ];
}
