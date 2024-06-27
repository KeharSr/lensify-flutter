import 'package:final_assignment/features/home/data/data_source/product_data_source.dart';
import 'package:final_assignment/features/home/presentation/state/product_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final productViewModelProvider =
    StateNotifierProvider<ProductsViewmodel, ProductState>((ref) {
  final productDataSource = ref.read(productDataSourceProvider);
  return ProductsViewmodel(productDataSource);
});

class ProductsViewmodel extends StateNotifier<ProductState> {
  final ProductDataSource _productDataSource;
  ProductsViewmodel(
    this._productDataSource,
  ) : super(
          ProductState.initial(),
        ) {
    getProducts();
  }

  Future resetState() async {
    state = ProductState.initial();
    getProducts();
  }

  Future getProducts() async {
    state = state.copyWith(isLoading: true);
    final currentState = state;
    final page = currentState.page + 1;
    final products = currentState.products;
    final hasReachedMax = currentState.hasReachedMax;
    if (!hasReachedMax) {
      // get data from data source
      final result = await _productDataSource.getAllProducts(page);
      result.fold(
        (failure) =>
            state = state.copyWith(hasReachedMax: true, isLoading: false),
        (data) {
          if (data.isEmpty) {
            state = state.copyWith(hasReachedMax: true);
          } else {
            state = state.copyWith(
              products: [...products, ...data],
              page: page,
              isLoading: false,
            );
          }
        },
      );
    }
  }
}
