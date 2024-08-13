import 'package:final_assignment/app/constants/api_endpoint.dart';
import 'package:final_assignment/features/product/domain/entity/product_entity.dart';
import 'package:final_assignment/features/single_product/presentation/view/single_product_view.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class MyProductCard extends StatelessWidget {
  final ProductEntity product;
  final double rating;
  final VoidCallback? onPressed;
  final VoidCallback? onWishlistTap;

  const MyProductCard({
    required this.product,
    required this.rating,
    super.key,
    this.onPressed,
    this.onWishlistTap,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl = '${ApiEndpoints.imageUrl}${product.productImage}';
    final theme = Theme.of(context); // Access the current theme
    final textColor =
        theme.textTheme.labelLarge?.color ?? Colors.black; // Default text color
    final isDarkMode =
        theme.brightness == Brightness.dark; // Check if dark mode is enabled

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductViewPage(productId: product.id!),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: theme.shadowColor.withOpacity(0.1),
              blurRadius: 4,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.productName,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: textColor, // Text color based on the theme
                        ),
                      ),
                      const SizedBox(height: 4),
                      // Display fetched rating
                      if (rating > 0)
                        Row(
                          children: [
                            Text(
                              'Rating: ',
                              style: TextStyle(
                                fontSize: 14,
                                color: textColor.withOpacity(
                                    0.7), // Slightly muted text color
                              ),
                            ),
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 16,
                            ),
                            Text(
                              rating.toStringAsFixed(1),
                              // Display the rating value
                              style: TextStyle(
                                fontSize: 14,
                                color: textColor.withOpacity(
                                    0.7), // Slightly muted text color
                              ),
                            ),
                          ],
                        )
                      else
                        Text(
                          'Rating: N/A',
                          style: TextStyle(
                            fontSize: 14,
                            color: textColor
                                .withOpacity(0.7), // Slightly muted text color
                          ),
                        ),
                      const SizedBox(height: 4),
                      Text(
                        product.productCategory,
                        style: TextStyle(
                          fontSize: 14,
                          color: textColor
                              .withOpacity(0.7), // Slightly muted text color
                        ),
                      ),
                      Text(
                        '\$${product.productPrice.toString()}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: textColor, // Text color based on the theme
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              right: 0,
              bottom: 35,
              child: Padding(
                padding: const EdgeInsets.all(1),
                child: IconButton(
                  icon: Icon(
                    Iconsax.heart5,
                    color:
                        theme.iconTheme.color, // Icon color based on the theme
                  ),
                  onPressed: onWishlistTap,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: IconButton(
                icon: Icon(
                  Iconsax.shopping_bag,
                  color: isDarkMode
                      ? Colors.red
                      : theme
                          .primaryColor, // Red in dark mode, theme primary color in light mode
                ),
                onPressed: onPressed,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
