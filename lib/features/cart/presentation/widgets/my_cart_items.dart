import 'package:final_assignment/app/constants/api_endpoint.dart';
import 'package:final_assignment/app/constants/colors.dart';
import 'package:final_assignment/features/cart/domain/entity/cart_entity.dart';
import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  final CartEntity cartItem;
  final VoidCallback? onIncreasePressed;
  final VoidCallback? onDecreasePressed;
  final VoidCallback? onDeletePressed;

  const CartItem({
    required this.cartItem,
    this.onIncreasePressed,
    this.onDecreasePressed,
    this.onDeletePressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl =
        '${ApiEndpoints.imageUrl}${cartItem.productId!.productImage}';
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),

          // Product Details and Controls
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Name
                Text(
                  cartItem.productId!.productName,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? TColors.textWhite : TColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),

                // Product Category and Description
                Text(
                  "${cartItem.productId!.productCategory}  ${cartItem.productId!.productDescription}",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: isDarkMode
                        ? TColors.textWhite.withOpacity(0.7)
                        : TColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 8),

                // Quantity Controls, Price, and Delete Button
                Row(
                  children: [
                    // Decrease Button
                    GestureDetector(
                      onTap: onDecreasePressed,
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: TColors.grey),
                        ),
                        child: const Icon(
                          Icons.remove,
                          size: 16,
                          color: TColors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),

                    // Quantity Display
                    Text(
                      cartItem.quantity.toString(),
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isDarkMode
                            ? TColors.textWhite
                            : TColors.textPrimary,
                      ),
                    ),
                    const SizedBox(width: 16),

                    // Increase Button
                    GestureDetector(
                      onTap: onIncreasePressed,
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: TColors.primary,
                        ),
                        child: const Center(
                          child: Icon(Icons.add, size: 16, color: Colors.white),
                        ),
                      ),
                    ),
                    const Spacer(),

                    // Price Display
                    Text(
                      "\$${cartItem.productId!.productPrice * cartItem.quantity}",
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: TColors.primary,
                      ),
                    ),
                    const SizedBox(width: 16),

                    // Delete Button
                    GestureDetector(
                      onTap: onDeletePressed,
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: TColors.error,
                        ),
                        child: const Center(
                          child:
                              Icon(Icons.delete, size: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
