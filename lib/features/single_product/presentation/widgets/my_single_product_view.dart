import 'package:final_assignment/app/constants/api_endpoint.dart';
import 'package:final_assignment/app/constants/colors.dart';
import 'package:final_assignment/app/constants/sizes.dart';
import 'package:final_assignment/features/product/domain/entity/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:iconsax/iconsax.dart';

class MySingleProductView extends StatelessWidget {
  final ProductEntity product;
  final TextEditingController reviewController;
  final Function(String) addReview;
  final VoidCallback onDecreaseQuantity;
  final VoidCallback onIncreaseQuantity;
  final int selectedQuantity;
  final VoidCallback onCartPressed;
  final Function(double rating, String review) reviewonPressed;
  final Function(double rating, String review) updateReview;
  final double rating;
  final bool userHasReviewed;
  final double averageRating;
  final List<String> reviews;

  const MySingleProductView({
    super.key,
    required this.product,
    required this.reviewController,
    required this.addReview,
    required this.onDecreaseQuantity,
    required this.onIncreaseQuantity,
    required this.selectedQuantity,
    required this.onCartPressed,
    required this.reviewonPressed,
    required this.updateReview,
    required this.rating,
    required this.userHasReviewed,
    required this.averageRating,
    required this.reviews,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl = '${ApiEndpoints.imageUrl}${product.productImage}';
    double newRating = 0;
    double updateRating = 0;

    return Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 100),
          child: Column(
            children: [
              // Product Image
              AspectRatio(
                aspectRatio: 1,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.contain,
                ),
              ),
              // Product Details
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(30)),
                ),
                padding: const EdgeInsets.all(TSizes.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Name, Rating and Reviews
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Iconsax.star,
                              color: TColors.secondaryColor,
                              size: TSizes.iconMd,
                            ),
                            const SizedBox(width: TSizes.sm),
                            Text(
                              averageRating.toStringAsFixed(1),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: TSizes.xs),
                            Text(
                              '(${reviews.length})',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                        Text(
                          '\$${product.productPrice}',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: TSizes.md),
                    // Product Name
                    Text(
                      product.productName,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: TSizes.sm),
                    // Stock Status and Category
                    Row(
                      children: [
                        // Text(
                        //   'Stock: ${product.isInStock ? "In Stock" : "Out of Stock"}',
                        //   style: TextStyle(
                        //     color: product.isInStock
                        //         ? Colors.green
                        //         : TColors.error,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                        const SizedBox(width: TSizes.md),
                        Row(
                          children: [
                            Icon(
                              Iconsax.tag,
                              color: Theme.of(context).primaryColor,
                              size: TSizes.iconSm,
                            ),
                            const SizedBox(width: TSizes.xs),
                            Text(
                              product.productCategory,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: TSizes.md),
                    // Description
                    Text(
                      'Description',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: TSizes.sm),
                    Text(
                      product.productDescription,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(fontWeight: FontWeight.normal),
                    ),
                    const SizedBox(height: TSizes.md),
                    const Divider(),
                    // Reviews Section
                    Text(
                      'Reviews (${reviews.length})',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: TSizes.sm),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...reviews.map((review) => Padding(
                              padding: const EdgeInsets.only(bottom: TSizes.sm),
                              child: Text(review,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(fontWeight: FontWeight.w200)),
                            )),
                        if (!userHasReviewed) ...[
                          const SizedBox(height: TSizes.md),
                          TextField(
                            controller: reviewController,
                            decoration: InputDecoration(
                              hintText: 'Add a review',
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.send),
                                onPressed: () {
                                  reviewonPressed(
                                      newRating, reviewController.text);
                                  addReview(reviewController.text);
                                  reviewController.clear();
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: TSizes.sm),
                          RatingBar.builder(
                            initialRating: rating,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 24,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (newRatingValue) {
                              newRating = newRatingValue;
                            },
                          ),
                        ],
                        if (userHasReviewed) ...[
                          const SizedBox(height: TSizes.md),
                          TextField(
                            controller: reviewController,
                            decoration: InputDecoration(
                              hintText: 'Update your review',
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.send),
                                onPressed: () {
                                  updateReview(
                                      updateRating, reviewController.text);
                                  addReview(reviewController.text);
                                  reviewController.clear();
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: TSizes.sm),
                          RatingBar.builder(
                            initialRating: rating,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 24,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (newRatingValue) {
                              updateRating = newRatingValue;
                            },
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Docked Add to Bag with Quantity
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            color: Theme.of(context).cardColor,
            padding: const EdgeInsets.all(TSizes.md),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Quantity Control
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Iconsax.minus, size: 20),
                        onPressed: product.productQuantity > 0
                            ? onDecreaseQuantity
                            : null,
                      ),
                      Text(
                        '$selectedQuantity',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      IconButton(
                        icon: const Icon(Iconsax.add, size: 20),
                        onPressed: product.productQuantity > 0
                            ? onIncreaseQuantity
                            : null,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: TSizes.sm),
                // Add to Cart Button
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: TColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: onCartPressed,
                    child: const Text('Add to Cart'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
