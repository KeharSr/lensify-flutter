// import 'package:final_assignment/core/common/widgets/my_appbar.dart';
// import 'package:final_assignment/core/common/widgets/my_cart_items.dart';
// import 'package:final_assignment/core/common/widgets/my_search_container.dart';
// import 'package:final_assignment/features/cart/presentation/viewmodel/cart_view_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// class CartView extends ConsumerStatefulWidget {
//   const CartView({super.key});
//
//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _CartViewState();
// }
//
// class _CartViewState extends ConsumerState<CartView> {
//   final ScrollController _scrollController = ScrollController();
//
//   @override
//   void initState() {
//     super.initState();
//     Future.microtask(() => ref.read(cartViewModelProvider.notifier).getCarts());
//   }
//
//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final cartState = ref.watch(cartViewModelProvider);
//
//     return Scaffold(
//       appBar: MyAppbar(
//         title: const Text(
//           'My Cart',
//           style: TextStyle(color: Colors.black),
//         ),
//         showBackArrow: true,
//       ),
//       body: RefreshIndicator(
//         onRefresh: () async {
//           await ref.read(cartViewModelProvider.notifier).getCarts();
//         },
//         child: CustomScrollView(
//           controller: _scrollController,
//           slivers: [
//             SliverToBoxAdapter(
//               child: Column(
//                 children: [
//                   const MySearchContainer(
//                     text: 'Search in cart',
//                     icon: Icons.search,
//                   ),
//                   const SizedBox(height: 16),
//                 ],
//               ),
//             ),
//             if (cartState.isLoading)
//               const SliverFillRemaining(
//                 child: Center(
//                   child: CircularProgressIndicator(),
//                 ),
//               )
//             else if (cartState.error != null)
//               SliverFillRemaining(
//                 child: Center(
//                   child: Text(
//                     'Error: ${cartState.error}',
//                     style: const TextStyle(color: Colors.black),
//                   ),
//                 ),
//               )
//             else if (cartState.products.isEmpty)
//               const SliverFillRemaining(
//                 child: Center(
//                   child: Text(
//                     'Your cart is empty',
//                     style: TextStyle(color: Colors.black),
//                   ),
//                 ),
//               )
//             else
//               SliverPadding(
//                 padding: const EdgeInsets.all(16.0),
//                 sliver: SliverList(
//                   delegate: SliverChildBuilderDelegate(
//                     (context, index) {
//                       final cartItem = cartState.products[index];
//                       return Padding(
//                         padding: const EdgeInsets.only(bottom: 8.0),
//                         child: CartItem(cartItem: cartItem),
//                       );
//                     },
//                     childCount: cartState.products.length,
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: cartState.products.isNotEmpty
//           ? Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.blue,
//                   minimumSize: const Size(double.infinity, 50),
//                 ),
//                 onPressed: () {
//                   // Implement checkout logic
//                 },
//                 child: Text(
//                   'Checkout \$${cartState.products.fold(0, (sum, item) => sum + (item.productId!.productPrice * item.quantity)).toStringAsFixed(2)}',
//                 ),
//               ),
//             )
//           : const SizedBox
//               .shrink(), // Remove the 'New Text' and use an empty widget instead
//     );
//   }
// }

import 'package:final_assignment/core/common/widgets/my_appbar.dart';
import 'package:final_assignment/core/common/widgets/my_cart_items.dart';
import 'package:final_assignment/features/cart/presentation/viewmodel/cart_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartView extends ConsumerStatefulWidget {
  const CartView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CartViewState();
}

class _CartViewState extends ConsumerState<CartView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(cartViewModelProvider.notifier).getCarts();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartState = ref.watch(cartViewModelProvider);

    return Scaffold(
      appBar: const MyAppbar(
        title: Text(
          "Cart",
          style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        showBackArrow: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(cartViewModelProvider.notifier).getCarts();
        },
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: cartState.products.length,
                itemBuilder: (context, index) {
                  final cartItem = cartState.products[index];
                  return CartItem(cartItem: cartItem);
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () {
                  // Add checkout logic here
                  print("Proceeding to checkout");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Checkout",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "\$${cartState.products.fold(0, (sum, item) => sum + (item.productId!.productPrice * item.quantity)).toStringAsFixed(2)}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
