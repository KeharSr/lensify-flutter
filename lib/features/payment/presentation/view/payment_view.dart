// import 'dart:developer';
//
// import 'package:flutter/material.dart';
// import 'package:khalti_checkout_flutter/khalti_checkout_flutter.dart';
//
// class PaymentView extends StatefulWidget {
//   const PaymentView({super.key, required this.pidx});
//
//   final String pidx;
//
//   @override
//   State<PaymentView> createState() => _PaymentViewState();
// }
//
// class _PaymentViewState extends State<PaymentView> {
//   late final Future<Khalti?> khalti;
//
//   PaymentResult? paymentResult;
//
//   @override
//   void initState() {
//     super.initState();
//     final payConfig = KhaltiPayConfig(
//       publicKey: '064d32e438be480288e4d15e300cbfce',
//       pidx: widget.pidx,
//       environment: Environment.test,
//     );
//
//     khalti = Khalti.init(
//       enableDebugging: true,
//       payConfig: payConfig,
//       onPaymentResult: (paymentResult, khalti) {
//         log(paymentResult.toString());
//         setState(() {
//           this.paymentResult = paymentResult;
//         });
//         khalti.close(context);
//       },
//       onMessage: (
//         khalti, {
//         description,
//         statusCode,
//         event,
//         needsPaymentConfirmation,
//       }) async {
//         log(
//           'Description: $description, Status Code: $statusCode, Event: $event, NeedsPaymentConfirmation: $needsPaymentConfirmation',
//         );
//         log('confiramtiona=== $needsPaymentConfirmation');
//         khalti.close(context);
//       },
//       onReturn: () => log('Successfully redirected to return_url.'),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: FutureBuilder(
//           future: khalti,
//           initialData: null,
//           builder: (context, snapshot) {
//             final khaltiSnapshot = snapshot.data;
//             if (khaltiSnapshot == null) {
//               return const CircularProgressIndicator.adaptive();
//             }
//             return Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Image.asset(
//                   'assets/images/seru.png',
//                   height: 200,
//                   width: 200,
//                 ),
//                 const SizedBox(height: 120),
//                 const Text(
//                   'Rs. 22',
//                   style: TextStyle(fontSize: 25),
//                 ),
//                 const Text('1 day fee'),
//                 OutlinedButton(
//                   onPressed: () => khaltiSnapshot.open(context),
//                   child: const Text('Pay with Khalti'),
//                 ),
//                 const SizedBox(height: 120),
//                 paymentResult == null
//                     ? Text(
//                         'pidx: $widget!.pidx',
//                         style: const TextStyle(fontSize: 15),
//                       )
//                     : Column(
//                         children: [
//                           Text(
//                             'pidx: ${paymentResult!.payload?.pidx}',
//                           ),
//                           Text('Status: ${paymentResult!.payload?.status}'),
//                           Text(
//                             'Amount Paid: ${paymentResult!.payload?.totalAmount}',
//                           ),
//                           Text(
//                             'Transaction ID: ${paymentResult!.payload?.transactionId}',
//                           ),
//                         ],
//                       ),
//                 const SizedBox(height: 120),
//                 const Text(
//                   'Make an payment to clam the insurance package.',
//                   style: TextStyle(fontSize: 12),
//                 )
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:khalti_checkout_flutter/khalti_checkout_flutter.dart';
import 'package:lottie/lottie.dart';

class PaymentView extends StatefulWidget {
  const PaymentView({super.key, required this.pidx});

  final String pidx;

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
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
            colors: [Colors.blue.shade300, Colors.purple.shade300],
          ),
        ),
        child: Center(
          child: FutureBuilder<Khalti?>(
            future: khalti,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Lottie.network(
                  'https://assets5.lottiefiles.com/packages/lf20_usmfx6bp.json',
                  width: 200,
                  height: 200,
                );
              }
              final khaltiSnapshot = snapshot.data;
              if (khaltiSnapshot == null) {
                return Text('Failed to initialize Khalti',
                    style: TextStyle(color: Colors.white));
              }
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.network(
                        'https://assets9.lottiefiles.com/packages/lf20_9gvzjrcr.json',
                        width: 200,
                        height: 200,
                      ),
                      const SizedBox(height: 40),
                      Text(
                        'Rs. 22',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.3),
                      Text(
                        '1 day fee',
                        style: TextStyle(fontSize: 18, color: Colors.white70),
                      ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.3),
                      const SizedBox(height: 30),
                      ElevatedButton.icon(
                        onPressed: () => khaltiSnapshot.open(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        icon: Icon(Icons.payment, color: Colors.white),
                        label: Text(
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
                                Text(
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
                      Text(
                        'Make a payment to claim the insurance package.',
                        style: TextStyle(fontSize: 14, color: Colors.white),
                        textAlign: TextAlign.center,
                      ).animate().fadeIn(delay: 900.ms),
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
