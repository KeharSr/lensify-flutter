import 'package:final_assignment/features/product/domain/entity/product_entity.dart';

class SingleProductState {
  final ProductEntity? singleProduct;
  final bool isLoading;
  final String? error;

  SingleProductState({
    required this.singleProduct,
    required this.isLoading,
    required this.error,
  });

  factory SingleProductState.initial() => SingleProductState(
        singleProduct: null,
        isLoading: false,
        error: null,
      );

  SingleProductState copyWith({
    ProductEntity? singleProduct,
    bool? isLoading,
    String? error,
  }) {
    return SingleProductState(
      singleProduct: singleProduct ?? this.singleProduct,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
