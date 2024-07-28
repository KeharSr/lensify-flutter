// import 'package:final_assignment/app/constants/api_endpoint.dart';
// import 'package:flutter/material.dart';
//
// import '../../../product/domain/entity/product_entity.dart';
//
// class SingleView extends StatelessWidget {
//   final ProductEntity singleProduct;
//   final int selectedQuantity;
//   final VoidCallback onAddToBag;
//   final VoidCallback onIncreaseQuantity;
//   final VoidCallback onDecreaseQuantity;
//
//   const SingleView({
//     super.key,
//     required this.singleProduct,
//     required this.selectedQuantity,
//     required this.onAddToBag,
//     required this.onIncreaseQuantity,
//     required this.onDecreaseQuantity,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final imageUrl = '${ApiEndpoints.imageUrl}${singleProduct.productImage}';
//
//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Product Image
//           Image.network(
//             imageUrl,
//             fit: BoxFit.cover,
//             width: double.infinity,
//             height: 250,
//           ),
//           // Product Details
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     const Icon(Icons.star, color: Colors.yellow, size: 18),
//                     const SizedBox(width: 4),
//                     const Text('5.0 (199)',
//                         style: TextStyle(color: Colors.grey)),
//                     const Spacer(),
//                     IconButton(
//                       icon: const Icon(Icons.share),
//                       onPressed: () {},
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 10),
//                 Text(
//                   singleProduct.productName,
//                   style: const TextStyle(
//                       fontSize: 22, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 10),
//                 Text(
//                   '\$${singleProduct.productPrice}',
//                   style: const TextStyle(
//                       fontSize: 22, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 5),
//                 Text(
//                   'Stock: ${singleProduct.productQuantity > 0 ? "In Stock" : "Out of Stock"}',
//                   style: const TextStyle(color: Colors.grey),
//                 ),
//                 const SizedBox(height: 20),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [
//                         IconButton(
//                           icon: const Icon(Icons.remove),
//                           onPressed: singleProduct.productQuantity > 0
//                               ? onDecreaseQuantity
//                               : null,
//                         ),
//                         Text('$selectedQuantity'),
//                         IconButton(
//                           icon: const Icon(Icons.add),
//                           onPressed: singleProduct.productQuantity > 0
//                               ? onIncreaseQuantity
//                               : null,
//                         ),
//                       ],
//                     ),
//                     ElevatedButton.icon(
//                       onPressed:
//                           singleProduct.productQuantity > 0 ? onAddToBag : null,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: singleProduct.productQuantity > 0
//                             ? Colors.blue
//                             : Colors.grey,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         minimumSize: const Size(150, 40),
//                       ),
//                       icon: const Icon(Icons.shopping_bag),
//                       label: const Text(
//                         "Add to Bag",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:final_assignment/app/constants/api_endpoint.dart';
import 'package:flutter/material.dart';

import '../../../product/domain/entity/product_entity.dart';

class SingleView extends StatelessWidget {
  final ProductEntity singleProduct;
  final int selectedQuantity;
  final VoidCallback onAddToBag;
  final VoidCallback onIncreaseQuantity;
  final VoidCallback onDecreaseQuantity;

  const SingleView({
    Key? key,
    required this.singleProduct,
    required this.selectedQuantity,
    required this.onAddToBag,
    required this.onIncreaseQuantity,
    required this.onDecreaseQuantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageUrl = '${ApiEndpoints.imageUrl}${singleProduct.productImage}';

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          // Product Details
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        singleProduct.productName,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.share, color: Colors.blue),
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 20),
                    const SizedBox(width: 4),
                    const Text('5.0',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(width: 4),
                    Text('(199 reviews)',
                        style: TextStyle(color: Colors.grey[600])),
                  ],
                ),
                const SizedBox(height: 15),
                Text(
                  singleProduct.productDescription,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  '\$${singleProduct.productPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Stock: ${singleProduct.productQuantity > 0 ? "In Stock" : "Out of Stock"}',
                  style: TextStyle(
                    color: singleProduct.productQuantity > 0
                        ? Colors.green
                        : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: singleProduct.productQuantity > 0
                                ? onDecreaseQuantity
                                : null,
                          ),
                          Text(
                            '$selectedQuantity',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: singleProduct.productQuantity > 0
                                ? onIncreaseQuantity
                                : null,
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed:
                          singleProduct.productQuantity > 0 ? onAddToBag : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: singleProduct.productQuantity > 0
                            ? Colors.blue
                            : Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                      ),
                      icon: const Icon(Icons.shopping_bag_outlined,
                          color: Colors.white),
                      label: const Text(
                        "Add to Bag",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
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
