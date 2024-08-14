import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/shared_prefs/user_shared_prefs.dart';
import 'package:final_assignment/features/cart/domain/entity/cart_entity.dart';
import 'package:final_assignment/features/cart/domain/usecases/cart_usecase.dart';
import 'package:final_assignment/features/cart/presentation/navigator/cart_navigator.dart';
import 'package:final_assignment/features/cart/presentation/viewmodel/cart_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../test_data/cart_entity_data.dart';
import 'cart_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<CartUsecase>(),
])
Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  late CartViewNavigator mockCartViewNavigator;
  late CartUsecase mockCartUsecase;
  late ProviderContainer container;
  late UserSharedPrefs mockUserSharedPrefs;
  late List<CartEntity> carts;

  setUp(() {
    mockCartViewNavigator = CartViewNavigator();
    mockCartUsecase = MockCartUsecase();
    mockUserSharedPrefs = UserSharedPrefs();
    carts = CartTestData.getCartTestData();
    container = ProviderContainer(
      overrides: [
        cartViewModelProvider.overrideWith(
          (ref) => CartViewModel(
            cartUsecase: mockCartUsecase,
            navigator: mockCartViewNavigator,
            userSharedPrefs: mockUserSharedPrefs,
          ),
        ),
      ],
    );
  });

  test('check for the initial state in Cart State', () {
    final cartState = container.read(cartViewModelProvider);
    expect(cartState.isLoading, false);
    expect(cartState.error, isNull);
    expect(cartState.products, isEmpty);
  });

  // Test getCarts
  test('test cart and return sucess if sucessfully get', () async {
    when(mockCartUsecase.getCarts())
        .thenAnswer((_) => Future.value(Right(carts)));

    await container.read(cartViewModelProvider.notifier).getCarts();

    final cartState = container.read(cartViewModelProvider);

    expect(cartState.isLoading, false);
    expect(cartState.hasReachedMax, false);
    expect(cartState.products, carts);
    expect(cartState.error, null);
  });
}
