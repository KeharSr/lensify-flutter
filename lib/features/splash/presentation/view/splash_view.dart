// import 'package:final_assignment/features/splash/presentation/viewmodel/splash_view_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:lottie/lottie.dart';
//
// class SplashView extends ConsumerStatefulWidget {
//   const SplashView({super.key});
//
//   @override
//   ConsumerState<SplashView> createState() => _SplashViewState();
// }
//
// class _SplashViewState extends ConsumerState<SplashView> {
//   @override
//   void initState() {
//     ref.read(splashViewModelProvider.notifier).openLoginView();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blue[100],
//       body: Stack(
//         children: [
//           Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SizedBox(
//                   height: 400,
//                   width: 400,
//                   child: Lottie.asset('assets/animations/splash.json'),
//                 ),
//                 const Text(
//                   'Lensify',
//                   style: TextStyle(fontSize: 40, color: Colors.redAccent),
//                 ),
//                 const SizedBox(height: 10),
//                 // const CircularProgressIndicator(),
//                 // const SizedBox(height: 10),
//                 const Text('version : 1.0.0')
//               ],
//             ),
//           ),
//           Positioned(
//             bottom: 10,
//             left: MediaQuery.of(context).size.width / 3.4,
//             child: const Text(
//               'Developed by: Kehar',
//               style: TextStyle(fontSize: 15),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:final_assignment/features/splash/presentation/viewmodel/splash_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

import '../../../../app/constants/colors.dart';

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
    final size = MediaQuery.of(context).size;
    final brightness = Theme.of(context).brightness;
    final isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.grey[900] : TColors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.height * 0.4,
                    width: size.width * 0.8,
                    child: Lottie.asset('assets/animations/splash.json'),
                  ),
                  Text(
                    'Lensify',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: size.width * 0.1,
                      fontWeight: FontWeight.bold,
                      color: TColors.primary,
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Text(
                    'version : 1.0.0',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: size.width * 0.04,
                      color: isDarkMode ? Colors.white70 : Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: size.height * 0.02,
              left: 0,
              right: 0,
              child: Text(
                'Developed by: Kehar',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: size.width * 0.04,
                  color: isDarkMode ? Colors.white70 : Colors.black54,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
