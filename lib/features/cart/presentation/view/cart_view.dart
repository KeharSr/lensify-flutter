import 'package:final_assignment/app/constants/colors.dart';
import 'package:final_assignment/core/common/widgets/my_appbar.dart';
import 'package:final_assignment/features/cart/presentation/viewmodel/cart_view_model.dart';
import 'package:final_assignment/features/cart/presentation/widgets/my_cart_items.dart';
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
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: MyAppbar(
        title: Text(
          "Cart",
          style: TextStyle(
            color: isDarkMode ? TColors.textWhite : TColors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        showBackArrow: true,
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (scrollNotification is ScrollEndNotification &&
              _scrollController.position.extentAfter == 0) {
            ref.read(cartViewModelProvider.notifier).getCarts();
          }
          return true;
        },
        child: RefreshIndicator(
          onRefresh: () async {
            await ref.read(cartViewModelProvider.notifier).getCarts();
          },
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  controller: _scrollController,
                  itemCount: cartState.products.length,
                  itemBuilder: (context, index) {
                    final cartItem = cartState.products[index];
                    return CartItem(
                      cartItem: cartItem,
                      onDecreasePressed: () {
                        ref.read(cartViewModelProvider.notifier).updateCart(
                              cartItem.productId!,
                              cartItem.quantity - 1,
                            );
                      },
                      onIncreasePressed: () {
                        ref.read(cartViewModelProvider.notifier).updateCart(
                              cartItem.productId!,
                              cartItem.quantity + 1,
                            );
                      },
                      onDeletePressed: () {
                        ref
                            .read(cartViewModelProvider.notifier)
                            .deleteCart(cartItem.id!.toString());
                      },
                    );
                  },
                ),
              ),
              Container(
                color: theme.scaffoldBackgroundColor,
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed: () {
                    ref
                        .read(cartViewModelProvider.notifier)
                        .openCheckoutScreen();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: TColors.buttonPrimary,
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
                          color: TColors.textWhite,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "\$${cartState.products.fold(0, (sum, item) => sum + (item.productId!.productPrice * item.quantity)).toStringAsFixed(2)}",
                        style: const TextStyle(
                          color: TColors.textWhite,
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
      ),
    );
  }
}
