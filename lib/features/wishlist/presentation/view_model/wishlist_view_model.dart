import 'package:final_assignment/core/common/widgets/my_snackbar.dart';
import 'package:final_assignment/core/shared_prefs/user_shared_prefs.dart';
import 'package:final_assignment/features/wishlist/domain/usecase/wishlist_usecase.dart';
import 'package:final_assignment/features/wishlist/presentation/state/wishlist_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final wishlistViewModelProvider =
    StateNotifierProvider<WishlistViewModel, WishlistState>(
        (ref) => WishlistViewModel(
              wishlistUseCase: ref.watch(wishlistUseCaseProvider),
              userSharedPrefs: ref.watch(userSharedPrefsProvider),
            ));

class WishlistViewModel extends StateNotifier<WishlistState> {
  WishlistViewModel({
    required this.wishlistUseCase,
    required this.userSharedPrefs,
  }) : super(WishlistState.initial());

  final WishlistUsecase wishlistUseCase;
  final UserSharedPrefs userSharedPrefs;

  Future<void> getWishlist() async {
    state = state.copyWith(isLoading: true);
    final result = await wishlistUseCase.getWishlist();
    result.fold((failure) {
      state = state.copyWith(isLoading: false, error: failure.error);
      showMySnackBar(message: failure.error, color: Colors.red);
    }, (success) {
      state = state.copyWith(isLoading: false, favorites: success);
    });
  }
}
