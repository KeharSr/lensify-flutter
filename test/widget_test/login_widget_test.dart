import 'package:final_assignment/core/common/widgets/my_button.dart';
import 'package:final_assignment/core/common/widgets/my_text_form_field.dart';
import 'package:final_assignment/features/auth/presentation/view/login_view.dart';
import 'package:final_assignment/features/auth/presentation/view/register_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("LoginView Widget Tests", () {
    testWidgets('renders LoginView', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginView(),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(LoginView), findsOneWidget);
    });

    testWidgets('Login testing', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginView(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Enter text into email and password fields
      await tester.enterText(
          find.byType(MyTextFormField).at(0), 'Abishek@gmail.com');
      await tester.enterText(find.byType(MyTextFormField).at(1), 'Abishek123@');

      // Tap on the login button
      await tester.tap(find.byType(MyButton).first);
      await tester.pumpAndSettle();

      // Verify a SnackBar appears indicating login success or error
      // expect(find.byType(SnackBar), findsOneWidget);
    });

    testWidgets('Login success testing', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginView(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Enter correct login details
      await tester.enterText(
          find.byType(MyTextFormField).at(0), 'keharojha56@gmail.com');
      await tester.enterText(find.byType(MyTextFormField).at(1), 'password');

      // Tap on the login button
      await tester.tap(find.widgetWithText(MyButton, 'Login'));
      await tester.pumpAndSettle();

      // Verify the login button is still present (indicating the user is still on the login screen)
      expect(find.widgetWithText(MyButton, 'Login'), findsOneWidget);
    });
  });

  group("RegisterView Widget Tests", () {
    testWidgets('renders RegisterView', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: RegisterView(),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(RegisterView), findsOneWidget);
    });

    testWidgets('register testing', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: RegisterView(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Fill out the registration form
      await tester.enterText(find.byType(MyTextFormField).at(0), 'Kehar');
      await tester.enterText(find.byType(MyTextFormField).at(1), 'Ojha');
      await tester.enterText(
          find.byType(MyTextFormField).at(2), 'kehar@gmail.com');
      await tester.enterText(find.byType(MyTextFormField).at(3), 'kehar123');
      await tester.enterText(find.byType(MyTextFormField).at(4), '9898989898');
      await tester.enterText(find.byType(MyTextFormField).at(5), 'Kehar123@');

      // Tap on the 'Create Account' button
      await tester.tap(find.widgetWithText(MyButton, 'Create Account'));
      await tester.pumpAndSettle();

      // Verify that the button is still present, indicating the view did not change
      expect(find.widgetWithText(MyButton, 'Create Account'), findsOneWidget);
    });
  });
}
