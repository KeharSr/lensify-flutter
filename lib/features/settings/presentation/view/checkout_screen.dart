// import 'package:flutter/material.dart';

// class CheckoutScreen extends StatefulWidget {
//   const CheckoutScreen({super.key});

//   @override
//   _CheckoutScreenState createState() => _CheckoutScreenState();
// }

// class _CheckoutScreenState extends State<CheckoutScreen> {
//   String _selectedPaymentMethod = 'Paypal';
//   final bool _showPaymentDropdown = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Row(
//                   children: [
//                     Icon(Icons.arrow_back, size: 24),
//                     SizedBox(width: 8),
//                     Text('Order Review',
//                         style: TextStyle(
//                             fontSize: 20, fontWeight: FontWeight.bold)),
//                   ],
//                 ),
//                 const SizedBox(height: 16),
//                 _buildOrderItem('Nike Track suit red'),
//                 _buildOrderItem('Green Nike sports shoe',
//                     subtitle: 'Size: EU 32 Color: Green'),
//                 const SizedBox(height: 16),
//                 _buildPromoCodeInput(),
//                 const SizedBox(height: 16),
//                 _buildTotalSection(),
//                 const SizedBox(height: 16),
//                 _buildPaymentMethod(),
//                 const SizedBox(height: 16),
//                 _buildShippingAddress(),
//                 const SizedBox(height: 16),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blue,
//                     minimumSize: const Size(double.infinity, 50),
//                   ),
//                   onPressed: () {},
//                   child: const Text('Checkout \$1615.4'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildOrderItem(String title, {String? subtitle}) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8.0),
//       child: Row(
//         children: [
//           Container(
//             width: 60,
//             height: 60,
//             color: Colors.grey[200],
//           ),
//           const SizedBox(width: 8),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
//               if (subtitle != null)
//                 Text(subtitle, style: const TextStyle(color: Colors.grey)),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildPromoCodeInput() {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey),
//         borderRadius: BorderRadius.circular(4),
//       ),
//       child: Row(
//         children: [
//           const Expanded(
//             child: TextField(
//               decoration: InputDecoration(
//                 hintText: 'Have a promo code? Enter here',
//                 border: InputBorder.none,
//                 contentPadding: EdgeInsets.symmetric(horizontal: 8),
//               ),
//             ),
//           ),
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.blue,
//               shape: const RoundedRectangleBorder(
//                 borderRadius: BorderRadius.only(
//                   topRight: Radius.circular(4),
//                   bottomRight: Radius.circular(4),
//                 ),
//               ),
//             ),
//             onPressed: () {},
//             child: const Text('Apply'),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTotalSection() {
//     return Column(
//       children: [
//         _buildTotalRow('Subtotal', '\$1464.0'),
//         _buildTotalRow('Shipping Fee', '\$5.00'),
//         _buildTotalRow('Tax Fee', '\$146.40'),
//         _buildTotalRow('Order Total', '\$1615.4', isBold: true),
//       ],
//     );
//   }

//   Widget _buildTotalRow(String label, String amount, {bool isBold = false}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(label,
//               style: TextStyle(
//                   fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
//           Text(amount,
//               style: TextStyle(
//                   fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
//         ],
//       ),
//     );
//   }

//   Widget _buildPaymentMethod() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text('Payment Method',
//             style: TextStyle(fontWeight: FontWeight.bold)),
//         const SizedBox(height: 8),
//         GestureDetector(
//           onTap: () => _showPaymentMethodBottomSheet(context),
//           child: Container(
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.grey),
//               borderRadius: BorderRadius.circular(4),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(_selectedPaymentMethod),
//                 const Icon(Icons.arrow_forward_ios, size: 16),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   void _showPaymentMethodBottomSheet(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (BuildContext context) {
//         return Container(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'Select Payment Method',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 16),
//               _buildPaymentOption('Paypal', 'P'),
//               _buildPaymentOption('Google Pay', 'G'),
//               _buildPaymentOption('Apple Pay', 'A'),
//               _buildPaymentOption('Visa', 'V'),
//               _buildPaymentOption('Master Card', 'M'),
//               _buildPaymentOption('Paytm', 'P'),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildPaymentOption(String name, String logoLetter) {
//     return ListTile(
//       leading: Container(
//         width: 40,
//         height: 40,
//         decoration: const BoxDecoration(
//           color: Colors.blue,
//           shape: BoxShape.circle,
//         ),
//         child: Center(
//           child: Text(
//             logoLetter,
//             style: const TextStyle(
//                 color: Colors.white, fontWeight: FontWeight.bold),
//           ),
//         ),
//       ),
//       title: Text(name),
//       trailing: const Icon(Icons.arrow_forward_ios, size: 16),
//       onTap: () {
//         setState(() {
//           _selectedPaymentMethod = name;
//         });
//         Navigator.pop(context);
//       },
//     );
//   }

// //   Widget _buildShippingAddress() {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         Row(
// //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //           children: [
// //             const Text('Shipping Address',
// //                 style: TextStyle(fontWeight: FontWeight.bold)),
// //             TextButton(
// //               child: const Text('View', style: TextStyle(color: Colors.blue)),
// //               onPressed: () {
// //                 _showAddressBottomSheet(context);
// //               },
// //             ),
// //           ],
// //         ),
// //         const SizedBox(height: 8),
// //         Container(
// //           padding: const EdgeInsets.all(8),
// //           decoration: BoxDecoration(
// //             border: Border.all(color: Colors.grey),
// //             borderRadius: BorderRadius.circular(4),
// //           ),
// //           child: const Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               Text('Coding with T'),
// //               Text('+923179059528', style: TextStyle(color: Colors.grey)),
// //               Text('82356 Timmy Coves, South Liana, Maine',
// //                   style: TextStyle(color: Colors.grey)),
// //             ],
// //           ),
// //         ),
// //       ],
// //     );
// //   }

// //   void _showAddressBottomSheet(BuildContext context) {
// //     showModalBottomSheet(
// //       context: context,
// //       shape: const RoundedRectangleBorder(
// //         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
// //       ),
// //       builder: (BuildContext context) {
// //         return Container(
// //           padding: const EdgeInsets.all(16),
// //           child: Column(
// //             mainAxisSize: MainAxisSize.min,
// //             children: [
// //               _buildAddressCard(
// //                 'Taimoor Sikander',
// //                 '+923178059528',
// //                 'Street 35, Islamabad, Federal 48000, Pakistan',
// //               ),
// //               _buildAddressCard(
// //                 'Maria Garcia',
// //                 '(+54) 1 234 5678',
// //                 '789 Oak Road, Buenos Aires, Buenos Aires 1001, Argentina',
// //               ),
// //               _buildAddressCard(
// //                 'Liam Johnson',
// //                 '+447890123456',
// //                 '10 Park Lane, London, England SW1A 1AA, United Kingdom',
// //               ),
// //               const SizedBox(height: 16),
// //               ElevatedButton(
// //                 style: ElevatedButton.styleFrom(
// //                   backgroundColor: Colors.blue,
// //                   minimumSize: const Size(double.infinity, 50),
// //                 ),
// //                 onPressed: () {
// //                   // Implement add new address functionality
// //                 },
// //                 child: const Text('Add new address'),
// //               ),
// //             ],
// //           ),
// //         );
// //       },
// //     );
// //   }

// //   Widget _buildAddressCard(String name, String phone, String address) {
// //     return Card(
// //       child: ListTile(
// //         title: Text(name),
// //         subtitle: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Text(phone),
// //             Text(address),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
//   Widget _buildShippingAddress() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const Text('Shipping Address',
//                 style: TextStyle(fontWeight: FontWeight.bold)),
//             TextButton(
//               child: const Text('View', style: TextStyle(color: Colors.blue)),
//               onPressed: () {
//                 _showAddressBottomSheet(context);
//               },
//             ),
//           ],
//         ),
//         const SizedBox(height: 8),
//         Container(
//           padding: const EdgeInsets.all(8),
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.grey),
//             borderRadius: BorderRadius.circular(4),
//           ),
//           child: const Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('Coding with T'),
//               Text('+923179059528', style: TextStyle(color: Colors.grey)),
//               Text('82356 Timmy Coves, South Liana, Maine',
//                   style: TextStyle(color: Colors.grey)),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   void _showAddressBottomSheet(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (BuildContext context) {
//         return Container(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               _buildAddressCard(
//                 'Taimoor Sikander',
//                 '+923178059528',
//                 'Street 35, Islamabad, Federal 48000, Pakistan',
//               ),
//               _buildAddressCard(
//                 'Maria Garcia',
//                 '(+54) 1 234 5678',
//                 '789 Oak Road, Buenos Aires, Buenos Aires 1001, Argentina',
//               ),
//               _buildAddressCard(
//                 'Liam Johnson',
//                 '+447890123456',
//                 '10 Park Lane, London, England SW1A 1AA, United Kingdom',
//               ),
//               const SizedBox(height: 16),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.blue,
//                   minimumSize: const Size(double.infinity, 50),
//                 ),
//                 onPressed: () {
//                   // Implement add new address functionality
//                 },
//                 child: const Text('Add new address'),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildAddressCard(String name, String phone, String address) {
//     return Card(
//       child: ListTile(
//         title: Text(name),
//         subtitle: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(phone),
//             Text(address),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String _selectedPaymentMethod = 'VISA';
  final TextEditingController _promoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        title: const Text('Order Review',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProductView(),
              const SizedBox(height: 16),
              _buildPromoCodeInput(),
              const SizedBox(height: 16),
              _buildTotalSection(),
              const SizedBox(height: 16),
              _buildPaymentMethod(),
              const SizedBox(height: 16),
              _buildShippingAddress(),
              const SizedBox(height: 24),
              _buildCheckoutButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductView() {
    return Row(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.shopping_bag, color: Colors.blue, size: 40),
        ),
        const SizedBox(width: 16),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('Nike',
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold)),
                  SizedBox(width: 4),
                  Icon(Icons.verified, color: Colors.blue, size: 16),
                ],
              ),
              Text('Green Nike sports shoe',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text('Size: EU 32  Color: Green',
                  style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPromoCodeInput() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _promoController,
              decoration: const InputDecoration(
                hintText: 'Have a promo code? Enter here',
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ),
          TextButton(
            child: const Text('Apply', style: TextStyle(color: Colors.blue)),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildTotalSection() {
    return Column(
      children: [
        _buildTotalRow('Subtotal', '\$1464.0'),
        _buildTotalRow('Shipping Fee', '\$5.00'),
        _buildTotalRow('Tax Fee', '\$146.40'),
        const Divider(),
        _buildTotalRow('Order Total', '\$1615.4', isBold: true),
      ],
    );
  }

  Widget _buildTotalRow(String label, String amount, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
          Text(amount,
              style: TextStyle(
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }

  Widget _buildPaymentMethod() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Payment Method',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.credit_card, size: 20, color: Colors.blue),
                const SizedBox(width: 8),
                Text(_selectedPaymentMethod,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
        TextButton(
          child: const Text('Change', style: TextStyle(color: Colors.blue)),
          onPressed: () => _showPaymentMethodBottomSheet(context),
        ),
      ],
    );
  }

  Widget _buildShippingAddress() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Shipping Address',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Text('Coding with T'),
              Text('+923179059528', style: TextStyle(color: Colors.grey)),
              Text('82356 Timmy Coves, South Liana, Maine 87665, USA',
                  style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
        TextButton(
          child: const Text('Change', style: TextStyle(color: Colors.blue)),
          onPressed: () => _showAddressBottomSheet(context),
        ),
      ],
    );
  }

  Widget _buildCheckoutButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: () {},
      child: const Text('Checkout \$1615.4'),
    );
  }

  void _showPaymentMethodBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Select Payment Method',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              _buildPaymentOption('Paypal', 'P'),
              _buildPaymentOption('Google Pay', 'G'),
              _buildPaymentOption('Apple Pay', 'A'),
              _buildPaymentOption('Visa', 'V'),
              _buildPaymentOption('Master Card', 'M'),
              _buildPaymentOption('Paytm', 'P'),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPaymentOption(String name, String logoLetter) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(logoLetter,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ),
      title: Text(name),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        setState(() {
          _selectedPaymentMethod = name.toUpperCase();
        });
        Navigator.pop(context);
      },
    );
  }

  void _showAddressBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Select Address',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              _buildAddressCard(
                'Taimoor Sikander',
                '+923178059528',
                'Street 35, Islamabad, Federal 48000, Pakistan',
              ),
              _buildAddressCard(
                'Maria Garcia',
                '(+54) 1 234 5678',
                '789 Oak Road, Buenos Aires, Buenos Aires 1001, Argentina',
              ),
              _buildAddressCard(
                'Liam Johnson',
                '+447890123456',
                '10 Park Lane, London, England SW1A 1AA, United Kingdom',
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {},
                child: const Text('Add new address'),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAddressCard(String name, String phone, String address) {
    return Card(
      child: ListTile(
        title: Text(name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(phone),
            Text(address),
          ],
        ),
      ),
    );
  }
}
