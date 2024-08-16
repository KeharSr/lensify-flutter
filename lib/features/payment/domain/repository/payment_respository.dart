import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/payment/data/repository/payment_remote_repository.dart';
import 'package:final_assignment/features/payment/domain/entity/payment_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final paymentRepositoryProvider = Provider<IPaymentRepository>(
    (ref) => ref.read(paymentRemoteRepositoryProvider));

abstract class IPaymentRepository {
  Future<Either<Failure, String>> initializeKhaltiPayment({
    required String orderId,
    required double totalPrice,
  });

  // verify payment
  Future<Either<Failure, String>> verifyKhaltiPayment(PaymentEntity entity);
}
