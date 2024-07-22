import 'package:final_assignment/core/common/widgets/my_appbar.dart';
import 'package:final_assignment/core/common/widgets/my_cart_items.dart';
import 'package:final_assignment/core/common/widgets/my_search_container.dart';
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
    Future.microtask(() => ref.read(cartViewModelProvider.notifier).getCarts());
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
      appBar: MyAppbar(
        title: const Text(
          'My Cart',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Add any additional actions if needed
            },
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(cartViewModelProvider.notifier).getCarts();
        },
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              const MySearchContainer(
                text: 'Search in cart',
                icon: Icons.search,
              ),
              const SizedBox(height: 16),
              if (cartState.isLoading)
                const Center(
                  child: CircularProgressIndicator(),
                )
              else if (cartState.error != null)
                Center(
                  child: Text(
                    'Error: ${cartState.error}',
                    style: const TextStyle(color: Colors.white),
                  ),
                )
              else if (cartState.products.isEmpty)
                const Center(
                  child: Text(
                    'Your cart is empty',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              else
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: 4,
                        ),
                        itemCount: cartState.products.length,
                        itemBuilder: (context, index) {
                          final cartItem = cartState.products[index];
                          return MyCartItemCard(cartItem: cartItem);
                        },
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: cartState.products.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                child: Text(
                  'Checkout \$${cartState.products.fold(0, (sum, item) => sum + (item.productPrice * item.quantity)).toStringAsFixed(2)}',
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () {
                  // Implement checkout logic
                },
              ),
            )
          : null,
    );
  }
}
