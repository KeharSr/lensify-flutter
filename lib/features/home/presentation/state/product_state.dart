import 'package:final_assignment/features/home/domain/entity/product_entity.dart';

class ProductState {
  final List<ProductEntity> products;
  final bool hasReachedMax;
  final int page;
  final bool isLoading;
  final bool showFeedbackDialog;

  ProductState({
    required this.products,
    required this.hasReachedMax,
    required this.page,
    required this.isLoading,
    required this.showFeedbackDialog,
  });

  factory ProductState.initial() {
    return ProductState(
      products: [],
      hasReachedMax: false,
      page: 0,
      isLoading: false,
      showFeedbackDialog: false,
    );
  }

  ProductState copyWith({
    List<ProductEntity>? products,
    bool? hasReachedMax,
    int? page,
    bool? isLoading,
    bool? showFeedbackDialog,
  }) {
    return ProductState(
      products: products ?? this.products,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      page: page ?? this.page,
      isLoading: isLoading ?? this.isLoading,
      showFeedbackDialog: showFeedbackDialog ?? this.showFeedbackDialog,
    );
  }
}
