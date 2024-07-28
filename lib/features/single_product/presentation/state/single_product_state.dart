import 'package:final_assignment/features/product/domain/entity/product_entity.dart';

class SingleProductState {
  final ProductEntity? singleProduct;
  final bool isLoading;
  final String? error;
  final int selectedQuantity;

  SingleProductState({
    required this.singleProduct,
    required this.isLoading,
    required this.error,
    required this.selectedQuantity,
  });

  factory SingleProductState.initial() => SingleProductState(
        singleProduct: null,
        isLoading: false,
        error: null,
        selectedQuantity: 1,
      );

  SingleProductState copyWith({
    ProductEntity? singleProduct,
    bool? isLoading,
    String? error,
    int? selectedQuantity,
  }) {
    return SingleProductState(
      singleProduct: singleProduct ?? this.singleProduct,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      selectedQuantity: selectedQuantity ?? this.selectedQuantity,
    );
  }
}
