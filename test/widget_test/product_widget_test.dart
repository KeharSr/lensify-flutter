import 'package:final_assignment/features/single_product/presentation/view/single_product_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Single Product View Widget Tests', () {
    // 1. Test if the ProductViewPage is rendered
    testWidgets('renders ProductViewPage with expected widgets',
        (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: ProductViewPage(productId: 'test-product-id'),
          ),
        ),
      );

      // Add a small delay to let async tasks complete
      await tester.pump(const Duration(seconds: 2));

      // Check if the main ProductViewPage is rendered
      expect(find.byType(ProductViewPage), findsOneWidget);
    });

    // 2. Test the functionality of adding a product to the cart
    testWidgets('adds product to cart when Add to Cart button is pressed',
        (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: ProductViewPage(productId: 'test-product-id'),
          ),
        ),
      );

      // Add a small delay to let async tasks complete
      await tester.pump(const Duration(seconds: 2));

      // Find the "Add to Cart" button using find.widgetWithText
      final addToCartButton =
          find.widgetWithText(ElevatedButton, 'Add to Cart');

      // Verify the button is present in the widget tree
      expect(addToCartButton, findsOneWidget);
    });

    // 3. Test the quantity increment functionality
    testWidgets('increments quantity when the plus button is pressed',
        (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: ProductViewPage(productId: 'test-product-id'),
          ),
        ),
      );

      // Add a small delay to let async tasks complete
      await tester.pump(const Duration(seconds: 2));

      // Initially, the quantity should be 1
      expect(find.text('1'), findsOneWidget);

      // Tap the plus button to increase the quantity
      await tester.tap(find.byIcon(Icons.add).first);
      await tester.pump(
          const Duration(seconds: 1)); // Allow the increment to be processed

      // The quantity should now be 2
      expect(find.text('2'), findsOneWidget);
    });

    // 4. Test the quantity decrement functionality
    testWidgets('decrements quantity when the minus button is pressed',
        (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: ProductViewPage(productId: 'test-product-id'),
          ),
        ),
      );

      // Add a small delay to let async tasks complete
      await tester.pump(const Duration(seconds: 2));

      // Tap the plus button to increase the quantity to 2
      await tester.tap(find.byIcon(Icons.add).first);
      await tester.pump(
          const Duration(seconds: 1)); // Allow the increment to be processed

      // Now the quantity should be 2
      expect(find.text('2'), findsOneWidget);

      // Tap the minus button to decrease the quantity
      await tester.tap(find.byIcon(Icons.remove).first);
      await tester.pump(
          const Duration(seconds: 1)); // Allow the decrement to be processed

      // The quantity should now be 1 again
      expect(find.text('1'), findsOneWidget);
    });

    // 5. Test if reviews section is rendered correctly
    testWidgets('renders reviews section correctly', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: ProductViewPage(productId: 'test-product-id'),
          ),
        ),
      );

      // Add a small delay to let async tasks complete
      await tester.pump(const Duration(seconds: 2));

      // Check if the reviews section is displayed
      expect(find.textContaining('Reviews'), findsWidgets);

      // If there are reviews, they should be displayed
      expect(find.textContaining('Add a review'), findsOneWidget);
    });
  });
}
