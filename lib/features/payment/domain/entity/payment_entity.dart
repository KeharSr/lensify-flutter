import 'package:equatable/equatable.dart';

class PaymentEntity extends Equatable {
  final String? id;
  final String transactionId;
  final String pidx;
  final String orderId;
  final double totalPrice;
  final Map<String, dynamic>? dataFromVerificationReq;
  final Map<String, dynamic>? apiQueryFromUser;
  final String? paymentGateway;
  final String? status;

  const PaymentEntity(
      {this.id,
      required this.transactionId,
      required this.pidx,
      required this.orderId,
      required this.totalPrice,
      this.dataFromVerificationReq,
      this.apiQueryFromUser,
      this.paymentGateway,
      this.status});

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
