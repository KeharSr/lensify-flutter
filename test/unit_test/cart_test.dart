import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/shared_prefs/user_shared_prefs.dart';
import 'package:final_assignment/features/cart/domain/entity/cart_entity.dart';
import 'package:final_assignment/features/cart/domain/usecases/cart_usecase.dart';
import 'package:final_assignment/features/cart/presentation/viewmodel/cart_view_model.dart';
import 'package:final_assignment/features/home/presentation/navigator/home_navigator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'cart_entity_data.dart';
import 'cart_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<CartUsecase>(),
])
Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MainViewNavigator mockMainViewNavigator;
  late CartUsecase mockCartUsecase;
  late ProviderContainer container;
  late UserSharedPrefs mockUserSharedPrefs;
  late List<CartEntity> carts;

  setUp(() {
    mockMainViewNavigator = MainViewNavigator();
    mockCartUsecase = MockCartUsecase();
    mockUserSharedPrefs = UserSharedPrefs();
    carts = CartTestData.getCartTestData();
    container = ProviderContainer(
      overrides: [
        cartViewModelProvider.overrideWith(
          (ref) => CartViewModel(
            cartUsecase: mockCartUsecase,
            navigator: mockMainViewNavigator,
            userSharedPrefs: mockUserSharedPrefs,
          ),
        ),
      ],
    );
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

  // Test addCart success scenario
  // test('addCart should update state with success and call getCarts()',
  //     () async {
  //   // Arrange
  //   const productId = '1';
  //   const quantity = 1;
  //
  //   // Mock the addCart use case to return success
  //   when(mockCartUsecase.addCart(any, any))
  //       .thenAnswer((_) async => const Right(true));
  //
  //   // Mock the getCarts use case to return the cart list
  //   when(mockCartUsecase.getCarts()).thenAnswer((_) async => Right(carts));
  //
  //   // Act
  //   await container
  //       .read(cartViewModelProvider.notifier)
  //       .addCart(productId, quantity);
  //
  //   // Assert
  //   final cartState = container.read(cartViewModelProvider);
  //
  //   expect(cartState.isLoading, false);
  //   expect(cartState.error, null);
  //   expect(
  //       cartState.products, carts); // Ensure getCarts updates the products list
  //
  //   verify(mockCartUsecase.addCart(productId, quantity)).called(1);
  //   verify(mockCartUsecase.getCarts()).called(1);
  // });
}
