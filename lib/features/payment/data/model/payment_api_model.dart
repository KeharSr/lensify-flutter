import 'package:equatable/equatable.dart';
import 'package:final_assignment/features/payment/domain/entity/payment_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

part 'payment_api_model.g.dart';

// provider
final paymentApiModelProvider =
    Provider<PaymentApiModel>((ref) => PaymentApiModel.empty());

@JsonSerializable()
class PaymentApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String transactionId;
  final String pidx;
  final String orderId;
  final double totalPrice;
  final Map<String, dynamic>? dataFromVerificationReq;
  final Map<String, dynamic>? apiQueryFromUser;
  final String? paymentGateway;
  final String? status;

  const PaymentApiModel({
    this.id,
    required this.transactionId,
    required this.pidx,
    required this.orderId,
    required this.totalPrice,
    this.dataFromVerificationReq,
    this.apiQueryFromUser,
    this.paymentGateway,
    this.status,
  });

  const PaymentApiModel.empty()
      : this(
          id: '',
          transactionId: '',
          pidx: '',
          orderId: '',
          totalPrice: 0.0,
          dataFromVerificationReq: const {},
          apiQueryFromUser: const {},
          paymentGateway: '',
        );

  factory PaymentApiModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentApiModelToJson(this);

  // to entity
  PaymentEntity toEntity() {
    return PaymentEntity(
      id: id,
      transactionId: transactionId,
      pidx: pidx,
      orderId: orderId,
      totalPrice: totalPrice,
      dataFromVerificationReq: dataFromVerificationReq,
      apiQueryFromUser: apiQueryFromUser,
      paymentGateway: paymentGateway!,
      status: status,
    );
  }

  // from entity
  factory PaymentApiModel.fromEntity(PaymentEntity entity) {
    return PaymentApiModel(
      id: entity.id,
      transactionId: entity.transactionId,
      pidx: entity.pidx,
      orderId: entity.orderId,
      totalPrice: entity.totalPrice,
      dataFromVerificationReq: entity.dataFromVerificationReq,
      apiQueryFromUser: entity.apiQueryFromUser,
      paymentGateway: entity.paymentGateway,
      status: entity.status,
    );
  }

  // convert APi list to entity list
  List<PaymentEntity> toEntityList(List<PaymentApiModel> payments) {
    return payments.map((payment) => payment.toEntity()).toList();
  }

  // convert entity list to api list
  List<PaymentApiModel> fromEntityList(List<PaymentEntity> payments) {
    return payments
        .map((payment) => PaymentApiModel.fromEntity(payment))
        .toList();
  }

  @override
  List<Object?> get props => [
        id,
        transactionId,
        pidx,
        orderId,
        totalPrice,
        dataFromVerificationReq,
        apiQueryFromUser,
        paymentGateway,
        status,
      ];
}
