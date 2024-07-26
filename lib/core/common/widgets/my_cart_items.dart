import 'package:final_assignment/app/constants/api_endpoint.dart';
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
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
          // Product Details and Quantity Controls
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cartItem.productId!.productName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  cartItem.productId!.productDescription,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const Text(
                  "Color: Green Size: UK 08",
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(height: 8),
                // Quantity Controls and Delete Button
                Row(
                  children: [
                    GestureDetector(
                      onTap: onDecreasePressed,
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey),
                        ),
                        child: const Center(
                          child:
                              Icon(Icons.remove, size: 16, color: Colors.grey),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      cartItem.quantity.toString(),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 16),
                    GestureDetector(
                      onTap: onIncreasePressed,
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue,
                        ),
                        child: const Center(
                          child: Icon(Icons.add, size: 16, color: Colors.white),
                        ),
                      ),
                    ),
                    // Price
                    const SizedBox(width: 20),
                    Text(
                      "\$${cartItem.productId!.productPrice}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    // Delete Button
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: onDeletePressed,
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
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
