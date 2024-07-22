import 'package:final_assignment/core/common/widgets/my_snackbar.dart';
import 'package:final_assignment/core/shared_prefs/user_shared_prefs.dart';
import 'package:final_assignment/features/cart/domain/usecases/cart_usecase.dart';
import 'package:final_assignment/features/cart/presentation/state/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
final cartViewModelProvider = StateNotifierProvider<CartViewModel, CartState>(
  (ref) => CartViewModel(
    cartUsecase: ref.watch(cartUsecaseProvider),
    userSharedPrefs: ref.watch(userSharedPrefsProvider),
  )
);
class CartViewModel extends StateNotifier<CartState>{
  CartViewModel({
    required this.cartUsecase,
    required this.userSharedPrefs,
  }):super(CartState.initial());

  final CartUsecase cartUsecase;
  final UserSharedPrefs userSharedPrefs;

  //get cart
  Future<void> getCarts() async {
    state = state.copyWith(isLoading: true);
    final result = await cartUsecase.getCarts();
    var data = await cartUsecase.getCarts();
    data.fold(
      (failure){
        state = state.copyWith(isLoading: false, error: failure.error);
        showMySnackBar(message: failure.error,color: Colors.red);
      },
      (success){
        state = state.copyWith(isLoading: false, error: null);
        showMySnackBar(message: 'Cart fetched successfully',color: Colors.green);
      }
      
    );
  }
}