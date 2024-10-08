import 'package:final_assignment/app/constants/sizes.dart';
import 'package:final_assignment/features/cart/presentation/viewmodel/cart_view_model.dart';
import 'package:final_assignment/features/single_product/presentation/view_model/single_product_view_model.dart';
import 'package:final_assignment/features/single_product/presentation/widgets/my_single_product_view.dart';
import 'package:final_assignment/features/wishlist/presentation/view_model/wishlist_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductViewPage extends ConsumerStatefulWidget {
  final String productId;

  const ProductViewPage({super.key, required this.productId});

  @override
  _ProductViewPageState createState() => _ProductViewPageState();
}

class _ProductViewPageState extends ConsumerState<ProductViewPage> {
  TextEditingController reviewController = TextEditingController();
  double rating = 0;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref
        .read(singleProductViewModelProvider.notifier)
        .init(widget.productId));
  }

  @override
  void didUpdateWidget(covariant ProductViewPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.productId != oldWidget.productId) {
      ref.read(singleProductViewModelProvider.notifier).init(widget.productId);
    }
  }

  void _fetchProductDetails() {
    Future.microtask(() {
      ref
          .read(singleProductViewModelProvider.notifier)
          .getSingleProduct(widget.productId);
    });
  }

  void _fetchProductReviews() {
    Future.microtask(() {
      ref
          .read(singleProductViewModelProvider.notifier)
          .getReviewsByProduct(widget.productId);
    });
  }

  void addReview(String review) {
    setState(() {
      reviewController.clear();
    });
  }

  void reviewonPressed(double rating, String review) {
    ref
        .read(singleProductViewModelProvider.notifier)
        .addRatingReview(widget.productId, rating, review);
    _fetchProductReviews(); // Refresh reviews after adding
  }

  void updateReview(double rating, String review) {
    ref
        .read(singleProductViewModelProvider.notifier)
        .updateRatingReview(widget.productId, rating, review);
    _fetchProductReviews(); // Refresh reviews after updating
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final productState = ref.watch(singleProductViewModelProvider);
    final hasReviewed =
        ref.watch(singleProductViewModelProvider.notifier).hasReview();

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(TSizes.md),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: theme.iconTheme.color,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    IconButton(
                      onPressed: () {
                        ref
                            .read(wishlistViewModelProvider.notifier)
                            .addWishlist(productState.singleProduct!.id!);
                      },
                      icon: Icon(
                        Icons.favorite_border,
                        color: theme.iconTheme.color,
                      ),
                    ),
                  ],
                ),
              ),

              // Product Details
              if (productState.singleProduct != null)
                MySingleProductView(
                  product: productState.singleProduct!,
                  selectedQuantity: productState.selectedQuantity,
                  reviewController: reviewController,
                  addReview: addReview,
                  onDecreaseQuantity: () {
                    ref
                        .read(singleProductViewModelProvider.notifier)
                        .updateSelectedQuantity(
                            productState.selectedQuantity - 1);
                  },
                  onIncreaseQuantity: () {
                    ref
                        .read(singleProductViewModelProvider.notifier)
                        .updateSelectedQuantity(
                            productState.selectedQuantity + 1);
                  },
                  onCartPressed: () {
                    ref.read(cartViewModelProvider.notifier).addCart(
                        productState.singleProduct!.id!,
                        productState.selectedQuantity);
                  },
                  reviews: productState.reviews.map((e) => e.review).toList(),
                  reviewonPressed: reviewonPressed,
                  rating: rating,
                  updateReview: updateReview,
                  userHasReviewed: hasReviewed,
                  averageRating: productState.averageRating,
                ),
              if (productState.isLoading)
                const Center(child: CircularProgressIndicator()),
              if (productState.error != null)
                Center(
                  child: Text(
                    productState.error!,
                    style: const TextStyle(),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
