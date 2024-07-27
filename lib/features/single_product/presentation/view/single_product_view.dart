import 'package:final_assignment/core/common/widgets/my_appbar.dart';
import 'package:final_assignment/features/single_product/presentation/view_model/single_product_view_model.dart';
import 'package:final_assignment/features/single_product/presentation/widgets/my_single_product_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDetailsScreen extends ConsumerStatefulWidget {
  final String productId;

  const ProductDetailsScreen({required this.productId, super.key});

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends ConsumerState<ProductDetailsScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch the product details when the screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(singleProductViewModelProvider.notifier)
          .getSingleProduct(widget.productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final productState = ref.watch(singleProductViewModelProvider);

    return Scaffold(
      appBar: MyAppbar(
        title: const Text('Product Details'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: productState.isLoading
            ? const Center(child: CircularProgressIndicator())
            : productState.error != null
                ? Center(child: Text(productState.error!))
                : productState.singleProduct != null
                    ? ProductDetails(singleProduct: productState.singleProduct!)
                    : const Center(child: Text('Product not found')),
      ),
    );
  }
}
