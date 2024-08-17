import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khalti_checkout_flutter/khalti_checkout_flutter.dart';

import '../../domain/entity/payment_entity.dart';
import '../view_model/payment_view_model.dart';

class PaymentView extends ConsumerStatefulWidget {
  const PaymentView({super.key, required this.pidx});

  final String pidx;

  @override
  ConsumerState createState() => _PaymentViewState();
}

class _PaymentViewState extends ConsumerState<PaymentView> {
  late final Future<Khalti?> khalti;
  PaymentResult? paymentResult;

  @override
  void initState() {
    super.initState();
    final payConfig = KhaltiPayConfig(
      publicKey: '064d32e438be480288e4d15e300cbfce',
      pidx: widget.pidx,
      environment: Environment.test,
    );

    khalti = Khalti.init(
      enableDebugging: true,
      payConfig: payConfig,
      onPaymentResult: (paymentResult, khalti) {
        ref.read(paymentViewModelProvider.notifier).verifyKhaltiPayment(
              PaymentEntity(
                pidx: widget.pidx,
                status: paymentResult.payload?.status,
                totalPrice: paymentResult.payload?.totalAmount.toDouble() ?? 0,
                transactionId: paymentResult.payload?.transactionId ?? "",
                orderId: paymentResult.payload?.purchaseOrderId ?? "",
                id: paymentResult.payload?.purchaseOrderId ?? "",
              ),
            );
        khalti.close(context);
      },
      onMessage: (
        khalti, {
        description,
        statusCode,
        event,
        needsPaymentConfirmation,
      }) async {
        log(
          'Description: $description, Status Code: $statusCode, Event: $event, NeedsPaymentConfirmation: $needsPaymentConfirmation',
        );
        log('confirmation=== $needsPaymentConfirmation');
        khalti.close(context);
      },
      onReturn: () => log('Successfully redirected to return_url.'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue.shade300, Colors.purple.shade300],
          ),
        ),
        child: Center(
          child: FutureBuilder<Khalti?>(
            future: khalti,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator(
                  color: Colors.white,
                );
              }
              final khaltiSnapshot = snapshot.data;
              if (khaltiSnapshot == null) {
                return const Text('Failed to initialize Khalti',
                    style: TextStyle(color: Colors.white));
              }
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      const Text(
                        'Rs. 22',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.3),
                      const Text(
                        '1 day fee',
                        style: TextStyle(fontSize: 18, color: Colors.white70),
                      ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.3),
                      const SizedBox(height: 30),
                      ElevatedButton.icon(
                        onPressed: () => khaltiSnapshot.open(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        icon: const Icon(Icons.payment, color: Colors.white),
                        label: const Text(
                          'Pay with Khalti',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ).animate().shake(delay: 700.ms, duration: 1500.ms),
                      const SizedBox(height: 40),
                      if (paymentResult != null)
                        Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                const Text(
                                  'Payment Successful!',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                    'Status: ${paymentResult!.payload?.status}'),
                                Text(
                                  'Amount Paid: Rs. ${paymentResult!.payload?.totalAmount}',
                                ),
                                Text(
                                  'Transaction ID: ${paymentResult!.payload?.transactionId}',
                                ),
                              ],
                            ),
                          ),
                        ).animate().fadeIn().scale(),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
