class PaymentState {
  final bool isLoading;
  final bool isPaymentSuccess;
  final String? error;

  PaymentState({
    required this.isLoading,
    required this.isPaymentSuccess,
    required this.error,
  });

  factory PaymentState.initial() {
    return PaymentState(
      isLoading: false,
      isPaymentSuccess: false,
      error: null,
    );
  }

  PaymentState copyWith(
      {bool? isLoading, bool? isPaymentSuccess, String? error}) {
    return PaymentState(
        isLoading: isLoading ?? this.isLoading,
        isPaymentSuccess: isPaymentSuccess ?? this.isPaymentSuccess,
        error: error ?? this.error);
  }
}
