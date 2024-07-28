import 'package:final_assignment/core/common/widgets/my_appbar.dart';
import 'package:final_assignment/features/cart/presentation/viewmodel/cart_view_model.dart';
import 'package:final_assignment/features/single_product/presentation/view_model/single_product_view_model.dart';
import 'package:final_assignment/features/single_product/presentation/widgets/my_single_product_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SingleProductView extends ConsumerStatefulWidget {
  final String productId;

  const SingleProductView({required this.productId, super.key});

  @override
  _SingleProductViewState createState() => _SingleProductViewState();
}

class _SingleProductViewState extends ConsumerState<SingleProductView> {
  @override
  void initState() {
    super.initState();
    _fetchProductDetails();
  }

  void _fetchProductDetails() {
    Future.microtask(() {
      ref
          .read(singleProductViewModelProvider.notifier)
          .getSingleProduct(widget.productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final productState = ref.watch(singleProductViewModelProvider);

    return Scaffold(
      appBar: const MyAppbar(
        title: Text('Product Details'),
        showBackArrow: true,
      ),
      body: productState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : productState.error != null
              ? Center(child: Text(productState.error!))
              : productState.singleProduct != null
                  ? SingleView(
                      singleProduct: productState.singleProduct!,
                      selectedQuantity: productState.selectedQuantity,
                      onAddToBag: () {
                        ref.read(cartViewModelProvider.notifier).addCart(
                            productState.singleProduct!.id!,
                            productState.selectedQuantity);
                      },
                      onIncreaseQuantity: () {
                        ref
                            .read(singleProductViewModelProvider.notifier)
                            .updateSelectedQuantity(
                                productState.selectedQuantity + 1);
                      },
                      onDecreaseQuantity: () {
                        ref
                            .read(singleProductViewModelProvider.notifier)
                            .updateSelectedQuantity(
                                productState.selectedQuantity - 1);
                      },
                    )
                  : const Center(child: Text('Product not found')),
    );
  }
}
