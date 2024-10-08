import 'package:final_assignment/features/splash/presentation/navigator/splash_navigator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final splashViewModelProvider =
    StateNotifierProvider<SplashViewModel, void>((ref) {
  final navigator = ref.read(splashViewNavigatorProvider);
  return SplashViewModel(navigator);
});

class SplashViewModel extends StateNotifier<void> {
  SplashViewModel(this.navigator) : super(null);

  final SplashViewNavigator navigator;

  // Open Login page
  void openLoginView() {
    Future.delayed(const Duration(seconds: 3), () {
      navigator.openLoginView();
    });
  }


  void openHomeView() {
    // Your code goes here
  }
}
