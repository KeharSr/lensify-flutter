import 'package:final_assignment/features/cart/presentation/state/cart_state.dart';
import 'package:flutter/material.dart';

class MyAppBarIcon extends StatelessWidget {
  const MyAppBarIcon({
    super.key,
    required this.cartState,
  });

  final CartState cartState;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.shopify_sharp,
            color: Colors.white,
          ),
        ),
        if (cartState.products.isNotEmpty)
          Positioned(
            right: 0,
            child: Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Center(
                child: Text(
                  cartState.products.length.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
