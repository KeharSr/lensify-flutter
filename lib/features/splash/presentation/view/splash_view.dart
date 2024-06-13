


import 'package:final_assignment/features/splash/presentation/viewmodel/splash_view_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  @override
  void initState() {
    ref.read(splashViewModelProvider.notifier).openLoginView();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 400,
                  width: 400,
                  child: Lottie.asset('assets/animations/splash.json'),
                ),
                const Text(
                  'Lensify',
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.redAccent
                  ),
                ),
                const SizedBox(height: 10),
                // const CircularProgressIndicator(),
                // const SizedBox(height: 10),
                const Text('version : 1.0.0')
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            left: MediaQuery.of(context).size.width / 3.4,
            child: const Text(
              'Developed by: Kehar',
              style: TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
