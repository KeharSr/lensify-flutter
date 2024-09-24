import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:khalti_checkout_flutter/khalti_checkout_flutter.dart';

class PaymentView extends StatefulWidget {
  const PaymentView({super.key, required this.pidx});

  final String pidx;

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  late final Future<Khalti?> khalti;
  PaymentResult? paymentResult;
  bool isHovering = false;

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
        log(paymentResult.toString());
        setState(() {
          this.paymentResult = paymentResult;
        });
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
            colors: [Colors.purple.shade100, Colors.blue.shade100],
          ),
        ),
        child: Center(
          child: FutureBuilder(
            future: khalti,
            initialData: null,
            builder: (context, snapshot) {
              final khaltiSnapshot = snapshot.data;
              if (khaltiSnapshot == null) {
                return const CircularProgressIndicator.adaptive();
              }
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeInOut,
                        transform: Matrix4.identity()
                          ..scale(isHovering ? 1.05 : 1.0),
                        child: Image.asset(
                          'assets/images/khalti.png',
                          height: 200,
                          width: 200,
                        ),
                      ),
                      const SizedBox(height: 60),
                      Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              const Text(
                                'RS. 10',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.purple,
                                ),
                              ),
                              const Text(
                                'insurance per month',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 20),
                              MouseRegion(
                                onEnter: (_) =>
                                    setState(() => isHovering = true),
                                onExit: (_) =>
                                    setState(() => isHovering = false),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.easeInOut,
                                  transform: Matrix4.identity()
                                    ..scale(isHovering ? 1.05 : 1.0),
                                  child: ElevatedButton(
                                    onPressed: () =>
                                        khaltiSnapshot.open(context),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.deepPurple,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 30,
                                        vertical: 15,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                    child: const Text(
                                      'Pay with Khalti',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: paymentResult == null
                              ? Text(
                                  'PIDX: ${widget.pidx}',
                                  style: const TextStyle(fontSize: 15),
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Status: ${paymentResult!.payload?.status}',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      'Amount Paid: ${paymentResult!.payload?.totalAmount}',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      'Transaction ID: ${paymentResult!.payload?.transactionId}',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                        ),
                      ),
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
