import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/core/google/google_service.dart';
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:final_assignment/features/auth/domain/usecase/auth_usecase.dart';
import 'package:final_assignment/features/auth/presentation/navigator/login_navigator.dart';
import 'package:final_assignment/features/auth/presentation/navigator/register_navigator.dart';
import 'package:final_assignment/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:final_assignment/features/forgot_password/presentation/navigator/forgot_password_navigator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AuthUseCase>(),
  MockSpec<LoginViewNavigator>(),
  MockSpec<RegisterViewNavigator>(),
  MockSpec<ForgotPasswordViewNavigator>(),
  MockSpec<GoogleSignInService>()
])
Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AuthUseCase mockAuthUseCase;
  late LoginViewNavigator mockLoginViewNavigator;
  late RegisterViewNavigator mockRegisterViewNavigator;
  late ForgotPasswordViewNavigator mockForgotPasswordViewNavigator;
  late ProviderContainer container;
  late GoogleSignInService googleSignInService;

  setUp(() {
    mockAuthUseCase = MockAuthUseCase();
    mockLoginViewNavigator = MockLoginViewNavigator();
    mockRegisterViewNavigator = MockRegisterViewNavigator();
    mockForgotPasswordViewNavigator = MockForgotPasswordViewNavigator();
    googleSignInService = GoogleSignInService();
    container = ProviderContainer(overrides: [
      authViewModelProvider.overrideWith((ref) => AuthViewModel(
          mockLoginViewNavigator,
          mockRegisterViewNavigator,
          mockAuthUseCase,
          mockForgotPasswordViewNavigator,
          googleSignInService))
    ]);
  });

  test('check for the initial state in Auth State', () {
    final authState = container.read(authViewModelProvider);
    expect(authState.isLoading, false);
    expect(authState.error, isNull);
  });

  test('login test with valid username and password', () async {
    const correctEmail = 'kehar@gmail.com';
    const correctPassword = 'kehar1234';

    //Arrange
    when(mockAuthUseCase.loginUser(any, any)).thenAnswer((invocation) {
      final email = invocation.positionalArguments[0] as String;
      final password = invocation.positionalArguments[1] as String;

      return Future.value(email == correctEmail && password == correctPassword
          ? const Right(true)
          : Left(Failure(error: 'Invalid username or password')));
    });

    //Act
    await container
        .read(authViewModelProvider.notifier)
        .loginUser('kehar@gmail.com', 'kehar1234');

    final authState = container.read(authViewModelProvider);

    //Assert
    expect(authState.error, isNull);
  });

  // // Test createUser
  test('createUser test with valid user data', () async {
    // Arrange
    when(mockAuthUseCase.createUser(any)).thenAnswer((invocation) {
      final user = invocation.positionalArguments[0] as AuthEntity;

      return Future.value(user.email.isNotEmpty &&
              user.password!.isNotEmpty &&
              user.firstName.isNotEmpty &&
              user.lastName.isNotEmpty &&
              user.phoneNumber!.isNotEmpty &&
              user.userName.isNotEmpty
          ? const Right(true)
          : Left(Failure(error: 'Invalid user data')));
    });

    // Act
    await container
        .read(authViewModelProvider.notifier)
        .createUser(const AuthEntity(
          id: '1',
          firstName: 'Kehar',
          lastName: 'Singh',
          email: 'kehar@gmail.com',
          phoneNumber: '1234567890',
          userName: 'keharsr',
          password: 'password',
        ));

    final authState = container.read(authViewModelProvider);

    // Assert
    expect(authState.error, isNull);
    expect(authState.isLoading, isFalse);
  });

  tearDown(() {
    container.dispose();
  });
}
