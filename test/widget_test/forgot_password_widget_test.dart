import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:final_assignment/features/forgot_password/presentation/view/forgot_password_view.dart';
import 'package:iconsax/iconsax.dart';

void main() {
  group('ForgetPasswordView Widget Tests', () {
    testWidgets('renders ForgetPasswordView with expected widgets',
        (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: ForgetPasswordView(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Check if the ForgetPasswordView is rendered
      expect(find.byType(ForgetPasswordView), findsOneWidget);

      // Check if the "Forget Password" text is displayed
      expect(find.text('Forget Password'), findsOneWidget);

      // Check if the phone number TextField is displayed
      expect(find.widgetWithIcon(TextFormField, Icons.phone), findsOneWidget);

      // Check if the "Submit" button is displayed
      expect(find.text('Submit'), findsOneWidget);
    });

    testWidgets('shows OTP and password fields when Submit button is pressed',
        (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: ForgetPasswordView(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Enter a phone number
      await tester.enterText(find.byType(TextFormField).first, '1234567890');

      // Tap the "Submit" button
      await tester.tap(find.text('Submit'));

      // Allow time for the state to update and widgets to render
      await tester.pumpAndSettle();

      // Verify that the OTP and password fields are displayed
      expect(find.text('Enter OTP Here'), findsOneWidget);
      expect(find.widgetWithIcon(TextFormField, Iconsax.security), findsOneWidget);
      expect(find.widgetWithIcon(TextFormField, Iconsax.lock), findsNWidgets(2));
      expect(find.text('Verify OTP and Change Password'), findsOneWidget);
    });

    testWidgets('displays success message after changing password', (tester) async {
  await tester.pumpWidget(
    const ProviderScope(
      child: MaterialApp(
        home: ForgetPasswordView(),
      ),
    ),
  );

  // Simulate submitting the phone number
  await tester.enterText(find.byType(TextFormField).first, '1234567890');
  await tester.tap(find.text('Submit'));

  // Wait for the OTP and password fields to appear
  await tester.pumpAndSettle();

  // Check if the OTP input field is displayed after submitting the phone number
  expect(find.text('Enter OTP Here'), findsOneWidget);

  // Simulate entering OTP and new password
  await tester.enterText(find.widgetWithIcon(TextFormField, Iconsax.security), '123456');
  await tester.enterText(find.widgetWithIcon(TextFormField, Iconsax.lock).first, 'newpassword');
  await tester.enterText(find.widgetWithIcon(TextFormField, Iconsax.lock).last, 'newpassword');

  await tester.tap(find.text('Verify OTP and Change Password'));

  // Wait for the state to update and widgets to render
  await tester.pumpAndSettle();

  // Check if the success message is displayed
  expect(find.text('Your password has been changed successfully!'), findsOneWidget);
});
  });
}
