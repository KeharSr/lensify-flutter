import 'package:final_assignment/core/common/widgets/my_appbar.dart';
import 'package:final_assignment/features/cart/presentation/view/cart_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Cart page test widget', () {
    testWidgets('finds MyAppbar in cart view', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: CartView(),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.byType(MyAppbar), findsOneWidget);
    });

    testWidgets('Displays cart items correctly', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: CartView(),
          ),
        ),
      );

      await tester.pumpAndSettle();
      // Assuming there's a ListView or similar widget displaying the cart items
      expect(find.byType(ListView), findsOneWidget);
    });
  });
}
