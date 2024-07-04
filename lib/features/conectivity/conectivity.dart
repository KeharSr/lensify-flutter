// import 'package:final_assignment/core/common/provider/internet_connectivity.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// class Connectivity extends ConsumerStatefulWidget {
//   const Connectivity({super.key});
//
//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _ConnectivityState();
// }
//
// class _ConnectivityState extends ConsumerState<Connectivity> {
//
//   @override
//   Widget build(BuildContext context) {
//     final connectivityStatus = ref.watch(connectivityStatusProvider);
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Connectivity'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: const <Widget>[
//             Text('You have pushed the button this many times:'),
//           ],
//         ),
//       ),
//
//     );
//   }
// }

import 'package:final_assignment/core/common/provider/internet_connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class InternetCheckView extends StatelessWidget {
  const InternetCheckView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Internet Check'),
      ),
      body: Center(
        child: Consumer(
          builder: (context, ref, child) {
            final connectivityStatus = ref.watch(connectivityStatusProvider);
            if (connectivityStatus == ConnectivityStatus.isConnected) {
              return const Text(
                'Connected',
                style: TextStyle(fontSize: 24),
              );
            } else {
              return const Text(
                'Disconnected',
                style: TextStyle(fontSize: 24),
              );
            }
          },
        ),
      ),
    );
  }
}