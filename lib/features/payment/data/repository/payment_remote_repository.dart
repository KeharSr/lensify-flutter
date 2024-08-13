import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/payment/data/data_source/remote/payment_remote_data_source.dart';
import 'package:final_assignment/features/payment/domain/entity/payment_entity.dart';
import 'package:final_assignment/features/payment/domain/repository/payment_respository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// provider
final paymentRemoteRepositoryProvider =
    Provider<PaymentRemoteRepository>((ref) {
  final paymentRemoteDataSource = ref.watch(paymentRemoteDataSourceProvider);
  return PaymentRemoteRepository(
      paymentRemoteDataSource: paymentRemoteDataSource);
});

class PaymentRemoteRepository implements IPaymentRepository {
  final PaymentRemoteDataSource paymentRemoteDataSource;

  PaymentRemoteRepository({required this.paymentRemoteDataSource});

  @override
  Future<Either<Failure, String>> initializeKhaltiPayment(
      {required String orderId, required double totalPrice}) {
    return paymentRemoteDataSource.initializeKhaltiPayment(
      orderId: orderId,
      totalPrice: totalPrice,
    );
  }

  @override
  Future<Either<Failure, bool>> verifyKhaltiPayment(PaymentEntity entity) {
    return paymentRemoteDataSource.verifyKhaltiPayment(entity);
  }
}
