import 'package:final_assignment/app/constants/api_endpoint.dart';
import 'package:final_assignment/app/constants/colors.dart';
import 'package:final_assignment/features/product/domain/entity/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductDetails extends StatelessWidget {
  final ProductEntity product;
  final bool isDescriptionExpanded;
  final VoidCallback onDescriptionToggle;
  final bool isReviewsExpanded;
  final VoidCallback onReviewsToggle;
  final List<String> reviews;
  final TextEditingController reviewController;
  final Function(String) addReview;
  final VoidCallback onDecreaseQuantity;
  final VoidCallback onIncreaseQuantity;
  final int selectedQuantity;
  final VoidCallback onCartPressed;
  final Function(double rating, String review) reviewonPressed;
  final Function(double rating, String review) updateReview;
  final double rating;

  const ProductDetails({
    Key? key,
    required this.product,
    required this.isDescriptionExpanded,
    required this.onDescriptionToggle,
    required this.isReviewsExpanded,
    required this.onReviewsToggle,
    required this.reviews,
    required this.reviewController,
    required this.addReview,
    required this.onDecreaseQuantity,
    required this.onIncreaseQuantity,
    required this.selectedQuantity,
    required this.onCartPressed,
    required this.reviewonPressed,
    required this.updateReview,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageUrl = '${ApiEndpoints.imageUrl}${product.productImage}';
    double newRating = 0;
    double updateRating = 0;

    return SingleChildScrollView(
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
              color: Colors.grey[400],
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.productName,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '\$${product.productPrice}',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                GestureDetector(
                  onTap: onReviewsToggle,
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          '4.5',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${reviews.length} Reviews',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      Icon(isReviewsExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down),
                    ],
                  ),
                ),
                if (isReviewsExpanded) ...[
                  SizedBox(height: 16),
                  ...reviews.map((review) => Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Text(review),
                      )),
                  TextField(
                    controller: reviewController,
                    decoration: InputDecoration(
                      hintText: 'Add a review',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () {
                          reviewonPressed(rating, reviewController.text);
                          addReview(reviewController.text);
                          reviewController.clear();
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // For adding a rating
                  RatingBar.builder(
                    initialRating: 0,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 24,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (newRatingValue) {
                      newRating = newRatingValue;
                    },
                  ),
                ],
                if (reviews.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  TextField(
                    controller: reviewController,
                    decoration: InputDecoration(
                      hintText: 'Update a review',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () {
                          updateReview(updateRating, reviewController.text);
                          addReview(reviewController.text);
                          reviewController.clear();
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // For updating a rating
                  RatingBar.builder(
                    initialRating: rating,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 24,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (newRatingValue) {
                      updateRating = newRatingValue;
                    },
                  ),
                ],
                const SizedBox(height: 16),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: product.productQuantity > 0
                          ? onDecreaseQuantity
                          : null,
                    ),
                    Text(
                      '$selectedQuantity',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: product.productQuantity > 0
                          ? onIncreaseQuantity
                          : null,
                    ),
                  ],
                ),
                SizedBox(height: 16),
                GestureDetector(
                  onTap: onDescriptionToggle,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Description',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Icon(isDescriptionExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down),
                    ],
                  ),
                ),
                if (isDescriptionExpanded) ...[
                  SizedBox(height: 8),
                  Text(product.productDescription),
                ],
                SizedBox(height: 16),
                ElevatedButton(
                  child: Text('Add to Cart'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: TColors.primary,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  onPressed: onCartPressed,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
