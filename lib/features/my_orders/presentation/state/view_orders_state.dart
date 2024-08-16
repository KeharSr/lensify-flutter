import 'package:final_assignment/features/place_order/domain/entity/place_order_entity.dart';

class ViewOrdersState{
  final bool isLoading;
  final bool isLoaded;
  final String? error;
  final List<PlaceOrderEntity> orders;

  ViewOrdersState({
    required this.isLoading,
    required this.isLoaded,
    required this.error,
    required this.orders,
  });

  factory ViewOrdersState.initial() {
    return ViewOrdersState(
      isLoading: false,
      isLoaded: false,
      error: null,
      orders: [],
    );
  }

  ViewOrdersState copyWith({
    bool? isLoading,
    bool? isLoaded,
    String? error,
    List<PlaceOrderEntity>? orders,
  }) {
    return ViewOrdersState(
      isLoading: isLoading ?? this.isLoading,
      isLoaded: isLoaded ?? this.isLoaded,
      error: error ?? this.error,
      orders: orders ?? this.orders,
    );
  }
}