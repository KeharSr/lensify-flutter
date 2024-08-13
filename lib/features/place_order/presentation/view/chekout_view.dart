// import 'package:final_assignment/app/constants/api_endpoint.dart';
// import 'package:final_assignment/features/cart/domain/entity/cart_entity.dart';
// import 'package:final_assignment/features/place_order/domain/entity/place_order_entity.dart';
// import 'package:final_assignment/features/place_order/presentation/view_model/place_order_view_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// class CheckoutScreen extends ConsumerStatefulWidget {
//   final List<CartEntity> cartItems;
//
//   const CheckoutScreen({required this.cartItems, super.key});
//
//   @override
//   _CheckoutScreenState createState() => _CheckoutScreenState();
// }
//
// class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
//   final _formKey = GlobalKey<FormState>();
//
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _streetController = TextEditingController();
//   final TextEditingController _cityController = TextEditingController();
//   final TextEditingController _stateController = TextEditingController();
//   final TextEditingController _zipCodeController = TextEditingController();
//   final TextEditingController _countryController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//
//   @override
//   void dispose() {
//     _nameController.dispose();
//     _emailController.dispose();
//     _streetController.dispose();
//     _cityController.dispose();
//     _stateController.dispose();
//     _zipCodeController.dispose();
//     _countryController.dispose();
//     _phoneController.dispose();
//     super.dispose();
//   }
//
//   void _handleCheckout() {
//     if (_formKey.currentState?.validate() ?? false) {
//       final viewModel = ref.read(placeOrderViewModelProvider.notifier);
//
//       // Create a comma-separated string of product IDs
//       final products = widget.cartItems.map((cartItem) {
//         return {
//           'productId': cartItem.productId!.id.toString(),
//           'quantity': cartItem.quantity,
//         };
//       }).toList();
//
//       // Calculate the total price
//       final totalPrice = widget.cartItems.fold(0.0, (sum, item) {
//         return sum + (item.productId!.productPrice * item.quantity);
//       });
//       PlaceOrderEntity entity = PlaceOrderEntity(
//         name: _nameController.text,
//         email: _emailController.text,
//         street: _streetController.text,
//         city: _cityController.text,
//         state: _stateController.text,
//         zipCode: _zipCodeController.text,
//         country: _countryController.text,
//         phone: _phoneController.text,
//         paymentMethod: 'khalti',
//         carts: widget.cartItems,
//         payment: false,
//         totalPrice: totalPrice,
//         status: 'pending',
//       );
//       viewModel.placeOrder(
//         entity,
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final subtotal = widget.cartItems.fold(0.0, (sum, item) {
//       return sum + (item.productId!.productPrice * item.quantity);
//     });
//
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         title: const Text(
//           'Order Review',
//           style: TextStyle(color: Colors.black),
//         ),
//         backgroundColor: Colors.white,
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 for (var cartItem in widget.cartItems)
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 16.0),
//                     child: _buildProductItem(
//                         cartItem.productId!.productName,
//                         // Assuming there's a brand field
//                         '${ApiEndpoints.imageUrl}${cartItem.productId!.productImage}',
//                         price: cartItem.productId!.productPrice *
//                             cartItem.quantity,
//                         quantity: cartItem.quantity),
//                   ),
//                 const SizedBox(height: 16),
//                 _buildOrderSummary(subtotal),
//                 const SizedBox(height: 16),
//                 _buildPaymentMethod(),
//                 const SizedBox(height: 16),
//                 _buildShippingAddress(context),
//                 const SizedBox(height: 20),
//                 _buildCheckoutButton(subtotal),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildProductItem(
//     String title,
//     String imageUrl, {
//     required int price,
//     int? quantity,
//   }) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Image.network(imageUrl, height: 60, width: 60, fit: BoxFit.cover),
//         const SizedBox(width: 16),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 title,
//                 style:
//                     const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//               if (quantity != null)
//                 Text(
//                   'Quantity $quantity  ',
//                   style: const TextStyle(fontSize: 14, color: Colors.grey),
//                 ),
//             ],
//           ),
//         ),
//         Text(
//           '\$$price',
//           style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildOrderSummary(double subtotal) {
//     const shippingFee = 5.00;
//     final total = subtotal + shippingFee;
//
//     return Container(
//       padding: const EdgeInsets.all(16.0),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8.0),
//         border: Border.all(color: Colors.grey.shade300),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _buildSummaryRow('Subtotal', '\$$subtotal'),
//           _buildSummaryRow('Shipping Fee', '\$$shippingFee'),
//           const Divider(),
//           _buildSummaryRow('Order Total', '\$$total', isTotal: true),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSummaryRow(String title, String value, {bool isTotal = false}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             title,
//             style: TextStyle(
//               fontSize: isTotal ? 16 : 14,
//               fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
//             ),
//           ),
//           Text(
//             value,
//             style: TextStyle(
//               fontSize: isTotal ? 16 : 14,
//               fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildPaymentMethod() {
//     return Container(
//       padding: const EdgeInsets.all(16.0),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8.0),
//         border: Border.all(color: Colors.grey.shade300),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             children: [
//               Image.asset(
//                 'assets/images/khalti.png',
//                 height: 24, // Adjust the height according to your needs
//               ),
//               const SizedBox(width: 8),
//               const Text(
//                 'Khalti',
//                 style: TextStyle(fontSize: 16),
//               ),
//             ],
//           ),
//           GestureDetector(
//             onTap: () {},
//             child: const Text(
//               'Change',
//               style: TextStyle(fontSize: 16, color: Colors.blue),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildShippingAddress(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         TextFormField(
//           controller: _nameController,
//           decoration: const InputDecoration(labelText: 'Name'),
//           validator: (value) {
//             if (value == null || value.isEmpty) {
//               return 'Please enter your name';
//             }
//             return null;
//           },
//         ),
//         const SizedBox(height: 8),
//         TextFormField(
//           controller: _emailController,
//           decoration: const InputDecoration(labelText: 'Email'),
//           validator: (value) {
//             if (value == null || value.isEmpty) {
//               return 'Please enter your email';
//             }
//             return null;
//           },
//         ),
//         const SizedBox(height: 8),
//         TextFormField(
//           controller: _streetController,
//           decoration: const InputDecoration(labelText: 'Street'),
//           validator: (value) {
//             if (value == null || value.isEmpty) {
//               return 'Please enter your street address';
//             }
//             return null;
//           },
//         ),
//         const SizedBox(height: 8),
//         TextFormField(
//           controller: _cityController,
//           decoration: const InputDecoration(labelText: 'City'),
//           validator: (value) {
//             if (value == null || value.isEmpty) {
//               return 'Please enter your city';
//             }
//             return null;
//           },
//         ),
//         const SizedBox(height: 8),
//         TextFormField(
//           controller: _stateController,
//           decoration: const InputDecoration(labelText: 'State'),
//           validator: (value) {
//             if (value == null || value.isEmpty) {
//               return 'Please enter your state';
//             }
//             return null;
//           },
//         ),
//         const SizedBox(height: 8),
//         TextFormField(
//           controller: _zipCodeController,
//           decoration: const InputDecoration(labelText: 'Zip Code'),
//           validator: (value) {
//             if (value == null || value.isEmpty) {
//               return 'Please enter your zip code';
//             }
//             return null;
//           },
//         ),
//         const SizedBox(height: 8),
//         TextFormField(
//           controller: _countryController,
//           decoration: const InputDecoration(labelText: 'Country'),
//           validator: (value) {
//             if (value == null || value.isEmpty) {
//               return 'Please enter your country';
//             }
//             return null;
//           },
//         ),
//         const SizedBox(height: 8),
//         TextFormField(
//           controller: _phoneController,
//           decoration: const InputDecoration(labelText: 'Phone Number'),
//           validator: (value) {
//             if (value == null || value.isEmpty) {
//               return 'Please enter your phone number';
//             }
//             return null;
//           },
//         ),
//       ],
//     );
//   }
//
//   Widget _buildCheckoutButton(double total) {
//     final placeOrderState = ref.watch(placeOrderViewModelProvider);
//     return SizedBox(
//       width: double.infinity,
//       child: ElevatedButton(
//         onPressed: placeOrderState.isLoading ? null : _handleCheckout,
//         style: ElevatedButton.styleFrom(
//           padding: const EdgeInsets.symmetric(vertical: 16.0),
//           backgroundColor: Colors.blue,
//         ),
//         child: placeOrderState.isLoading
//             ? const CircularProgressIndicator(color: Colors.white)
//             : Text(
//                 'Checkout \$$total',
//                 style: const TextStyle(fontSize: 16),
//               ),
//       ),
//     );
//   }
// }

import 'package:final_assignment/app/constants/api_endpoint.dart';
import 'package:final_assignment/features/cart/domain/entity/cart_entity.dart';
import 'package:final_assignment/features/place_order/domain/entity/place_order_entity.dart';
import 'package:final_assignment/features/place_order/presentation/view_model/place_order_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../payment/presentation/view_model/payment_view_model.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  final List<CartEntity> cartItems;

  const CheckoutScreen({required this.cartItems, super.key});

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _streetController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipCodeController.dispose();
    _countryController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _handleCheckout() async {
    if (_formKey.currentState?.validate() ?? false) {
      final placeOrderViewModel =
          ref.read(placeOrderViewModelProvider.notifier);

      // Create a list of product data to be sent
      final products = widget.cartItems.map((cartItem) {
        return {
          'productId': cartItem.productId!.id.toString(),
          'quantity': cartItem.quantity,
        };
      }).toList();

      // Calculate the total price
      final totalPrice = widget.cartItems.fold(0.0, (sum, item) {
        return sum + (item.productId!.productPrice * item.quantity);
      });

      // Create the order entity
      PlaceOrderEntity entity = PlaceOrderEntity(
        name: _nameController.text,
        email: _emailController.text,
        street: _streetController.text,
        city: _cityController.text,
        state: _stateController.text,
        zipCode: _zipCodeController.text,
        country: _countryController.text,
        phone: _phoneController.text,
        paymentMethod: 'khalti',
        carts: widget.cartItems,
        payment: false,
        totalPrice: totalPrice,
        status: 'pending',
      );

      // Trigger place order function
      await placeOrderViewModel.placeOrder(entity);

      // If placing the order is successful, initialize Khalti payment
      if (ref.read(placeOrderViewModelProvider).error == null) {
        await ref
            .read(paymentViewModelProvider.notifier)
            .initializeKhaltiPayment(
              ref.watch(placeOrderViewModelProvider).placeOrder,
              totalPrice,
            );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final subtotal = widget.cartItems.fold(0.0, (sum, item) {
      return sum + (item.productId!.productPrice * item.quantity);
    });
    const shippingFee = 5.00;
    final total = subtotal + shippingFee;
    final placeOrderState = ref.watch(placeOrderViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Order Review',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // The product list UI
                ...widget.cartItems.map((cartItem) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          '${ApiEndpoints.imageUrl}${cartItem.productId!.productImage}',
                          height: 60,
                          width: 60,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cartItem.productId!.productName,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Quantity ${cartItem.quantity}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '\$${(cartItem.productId!.productPrice * cartItem.quantity).toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                const SizedBox(height: 16),
                // Order summary UI
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Subtotal',
                              style: TextStyle(fontSize: 14)),
                          Text('\$${subtotal.toStringAsFixed(2)}',
                              style: const TextStyle(fontSize: 14)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Shipping Fee',
                              style: TextStyle(fontSize: 14)),
                          const Text('\$5.00', style: TextStyle(fontSize: 14)),
                        ],
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Order Total',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '\$${total.toStringAsFixed(2)}',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Payment method UI
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/khalti.png',
                            height: 24,
                          ),
                          const SizedBox(width: 8),
                          const Text('Khalti', style: TextStyle(fontSize: 16)),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: const Text(
                          'Change',
                          style: TextStyle(fontSize: 16, color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Shipping address form fields
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _streetController,
                  decoration: const InputDecoration(labelText: 'Street'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your street address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _cityController,
                  decoration: const InputDecoration(labelText: 'City'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your city';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _stateController,
                  decoration: const InputDecoration(labelText: 'State'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your state';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _zipCodeController,
                  decoration: const InputDecoration(labelText: 'Zip Code'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your zip code';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _countryController,
                  decoration: const InputDecoration(labelText: 'Country'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your country';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(labelText: 'Phone Number'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                // Checkout button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed:
                        placeOrderState.isLoading ? null : _handleCheckout,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      backgroundColor: Colors.blue,
                    ),
                    child: placeOrderState.isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                            'Checkout \$$total',
                            style: const TextStyle(fontSize: 16),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
