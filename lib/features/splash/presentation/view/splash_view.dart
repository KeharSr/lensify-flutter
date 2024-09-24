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
