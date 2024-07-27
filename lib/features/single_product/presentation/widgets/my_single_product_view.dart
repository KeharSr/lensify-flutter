import 'package:final_assignment/app/constants/api_endpoint.dart';
import 'package:final_assignment/features/product/domain/entity/product_entity.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatelessWidget {
  final ProductEntity singleProduct;

  const ProductDetails({
    required this.singleProduct,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl = '${ApiEndpoints.imageUrl}${singleProduct.productImage}';

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.network(
                imageUrl,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 40,
                right: 10,
                child: IconButton(
                  icon: const Icon(Icons.favorite_border),
                  onPressed: () {},
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.star, color: Colors.yellow, size: 18),
                            Text(' 5.0 (199)',
                                style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Text(
                          singleProduct.productName,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.share),
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  '\$${singleProduct.productPrice}',
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const Text('Stock: In Stock',
                    style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {}, // Add quantity decrement logic
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                          ),
                          child: const Text('1'), // Default quantity
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {}, // Add quantity increment logic
                        ),
                      ],
                    ),
                    ElevatedButton.icon(
                      onPressed: () {}, // Add to bag logic
                      icon: const Icon(Icons.shopping_bag),
                      label: const Text('Add to Bag'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
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
