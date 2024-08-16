
import 'package:final_assignment/features/wishlist/domain/entity/wishlist_entity.dart';

class WishlistState {
  final List<WishlistEntity> favorites;
  final bool isLoading;
  final String? error;

  WishlistState({
    required this.favorites,
    required this.isLoading,
    required this.error,
  });

  factory WishlistState.initial() {
    return WishlistState(
      favorites: [],
      isLoading: false,
      error: null,
    );
  }

  WishlistState copyWith({
    List<WishlistEntity>? favorites,
    bool? isLoading,
    String? error,
  }) {
    return WishlistState(
      favorites: favorites ?? this.favorites,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
