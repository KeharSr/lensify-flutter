class PlaceOrderState {
  final String placeOrder;
  final bool isLoading;
  final String? error;

  PlaceOrderState({
    required this.placeOrder,
    required this.isLoading,
    required this.error,
  });

  factory PlaceOrderState.initial() {
    return PlaceOrderState(
      placeOrder: '',
      isLoading: false,
      error: null,
    );
  }

  PlaceOrderState copyWith({
    String? placeOrder,
    bool? isLoading,
    String? error,
  }) {
    return PlaceOrderState(
      placeOrder: placeOrder ?? this.placeOrder,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
