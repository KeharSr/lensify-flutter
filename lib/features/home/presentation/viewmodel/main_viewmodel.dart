import 'package:final_assignment/core/common/widgets/my_snackbar.dart';
import 'package:final_assignment/features/home/presentation/navigator/home_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mainViewModelProvider = StateNotifierProvider<MainViewModel, bool>(
  (ref) => MainViewModel(ref.read(mainViewNavigatorProvider)),
);

class MainViewModel extends StateNotifier<bool> {
  MainViewModel(this.mainNavigator) : super(false);
  final MainViewNavigator mainNavigator;

  void logout() async {
    showMySnackBar(message: 'Logging out....', backgroundColor: Colors.red);
    await Future.delayed(const Duration(seconds: 1));
    openLoginView();
  }

  openLoginView() {
    mainNavigator.openLoginView();
  }
}
