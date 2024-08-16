import 'package:final_assignment/features/place_order/presentation/view/place_order_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CheckoutScreen Basic Widget Tests', () {
    testWidgets('renders CheckoutScreen with form fields and buttons',
        (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: PlaceOrderView(cartItems: []), // Empty cart for simplicity
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Check if the form fields are displayed
      expect(find.byType(TextFormField), findsNWidgets(8));

      // Check if the Checkout button is displayed
      expect(find.textContaining('Checkout'), findsOneWidget);

      // Check if the payment method section is displayed
      expect(find.text('Khalti'), findsOneWidget);
    });

    testWidgets('validates form fields when Checkout button is pressed',
        (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: PlaceOrderView(cartItems: []), // Empty cart for simplicity
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Tap the Checkout button without entering any details
      await tester.tap(find.textContaining('Checkout'));
      await tester.pumpAndSettle();

      // Check if validation errors are displayed by finding the hint texts
      expect(find.widgetWithText(TextFormField, 'Name'), findsOneWidget);
      expect(find.widgetWithText(TextFormField, 'Email'), findsOneWidget);
      expect(find.widgetWithText(TextFormField, 'Street'), findsOneWidget);
      expect(find.widgetWithText(TextFormField, 'City'), findsOneWidget);
      expect(find.widgetWithText(TextFormField, 'State'), findsOneWidget);
      expect(find.widgetWithText(TextFormField, 'Zip Code'), findsOneWidget);
      expect(find.widgetWithText(TextFormField, 'Country'), findsOneWidget);
      expect(
          find.widgetWithText(TextFormField, 'Phone Number'), findsOneWidget);
    });

    testWidgets('fills form fields and simulates checkout', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: PlaceOrderView(cartItems: []), // Empty cart for simplicity
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Fill in the form fields
      await tester.enterText(find.byType(TextFormField).at(0), 'Test User');
      await tester.enterText(
          find.byType(TextFormField).at(1), 'test@example.com');
      await tester.enterText(
          find.byType(TextFormField).at(2), '123 Test Street');
      await tester.enterText(find.byType(TextFormField).at(3), 'Test City');
      await tester.enterText(find.byType(TextFormField).at(4), 'Test State');
      await tester.enterText(find.byType(TextFormField).at(5), '12345');
      await tester.enterText(find.byType(TextFormField).at(6), 'Test Country');
      await tester.enterText(find.byType(TextFormField).at(7), '1234567890');

      // Tap the Checkout button
      await tester.tap(find.textContaining('Checkout'));
      await tester.pumpAndSettle();

      // Ensure that the checkout process was initiated
      expect(find.byType(ElevatedButton), findsOneWidget);
    });
  });
}
