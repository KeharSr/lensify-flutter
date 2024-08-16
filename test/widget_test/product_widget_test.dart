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
  });
}
