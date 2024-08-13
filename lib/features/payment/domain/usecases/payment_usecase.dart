import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/payment/domain/repository/payment_respository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// provider
final paymentUsecaseProvider = Provider<PaymentUsecase>((ref) {
  final paymentRepository = ref.watch(paymentRepositoryProvider);
  return PaymentUsecase(paymentRepository: paymentRepository);
});

class PaymentUsecase {
  final IPaymentRepository paymentRepository;

  PaymentUsecase({required this.paymentRepository});

  Future<Either<Failure, String>> initializeKhaltiPayment(
      {required String orderId, required double totalPrice}) async {
    return paymentRepository.initializeKhaltiPayment(
        orderId: orderId, totalPrice: totalPrice);
  }
}
