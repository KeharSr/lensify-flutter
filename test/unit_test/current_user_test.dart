import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/google/google_service.dart';
import 'package:final_assignment/core/shared_prefs/user_shared_prefs.dart';
import 'package:final_assignment/features/auth/domain/usecase/auth_usecase.dart';
import 'package:final_assignment/features/home/presentation/navigator/home_navigator.dart';
import 'package:final_assignment/features/profile/presentation/viewmodel/current_user_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_test.mocks.dart';
import 'auth_test_data.dart';
import 'current_user_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<UserSharedPrefs>(),
  MockSpec<MainViewNavigator>(),
])
Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  late UserSharedPrefs mockUserSharedPrefs;
  late ProviderContainer container;
  late AuthUseCase mockAuthUseCase;
  late GoogleSignInService googleSignInService;
  late MainViewNavigator mockMainViewNavigator;

  setUp(() {
    mockAuthUseCase = MockAuthUseCase();
    mockUserSharedPrefs = MockUserSharedPrefs();
    googleSignInService = GoogleSignInService();
    mockMainViewNavigator = MockMainViewNavigator();
    container = ProviderContainer(overrides: [
      currentUserViewModelProvider.overrideWith((ref) => CurrentUserViewModel(
          authUseCase: mockAuthUseCase,
          userSharedPrefs: mockUserSharedPrefs,
          googleSignInService: googleSignInService,
          navigator: mockMainViewNavigator))
    ]);
  });

  // Test getCurrentUser
  test('get current user test', () async {
    // Arrange
    when(mockAuthUseCase.getCurrentUser()).thenAnswer((_) {
      return Future.value(Right(AuthTestData.getAuthTestData()));
    });

    when(mockUserSharedPrefs.checkId()).thenAnswer((_) {
      return Future.value(Right('668a6d8cd519d8fd3ec014de'));
    });

    // Act
    await container
        .read(currentUserViewModelProvider.notifier)
        .getCurrentUser();

    final authState = container.read(currentUserViewModelProvider);

    // Assert
    expect(authState.error, isNull);
    expect(authState.isLoading, isFalse);
    expect(authState.authEntity, AuthTestData.getAuthTestData());
  });

  // tear down the container
  tearDown(() {
    container.dispose();
  });
}
