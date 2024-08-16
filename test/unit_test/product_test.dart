import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/shared_prefs/user_shared_prefs.dart';
import 'package:final_assignment/features/home/presentation/navigator/home_navigator.dart';
import 'package:final_assignment/features/product/domain/entity/product_entity.dart';
import 'package:final_assignment/features/product/domain/usecase/product_usecase.dart';
import 'package:final_assignment/features/product/presentation/view_model/products_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../test_data/product_entity_data.dart';
import 'product_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<ProductUsecase>(),
  MockSpec<MainViewNavigator>(),
  MockSpec<UserSharedPrefs>(),
])
Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  late ProductUsecase mockProductUsecase;
  late MainViewNavigator mockMainViewNavigator;
  late UserSharedPrefs mockUserSharedPrefs;
  late ProviderContainer container;
  late List<ProductEntity> products;

  setUp(() {
    mockProductUsecase = MockProductUsecase();
    mockMainViewNavigator = MockMainViewNavigator();
    mockUserSharedPrefs = MockUserSharedPrefs();
    products = ProductTestData.getProductTestData();
    container = ProviderContainer(overrides: [
      productViewModelProvider.overrideWith((ref) => ProductViewmodel(
          productUsecase: mockProductUsecase,
          navigator: mockMainViewNavigator,
          userSharedPrefs: mockUserSharedPrefs))
    ]);
  });

  // Test getProducts
  test('get product entity and return true if sucessfully get', () async {
    when(mockProductUsecase.getProductsByCategory(1, 2, "All", ""))
        .thenAnswer((_) => Future.value(Right(products)));

    // Test getProducts
    await container
        .read(productViewModelProvider.notifier)
        .getProductsByCategory('All');

    // store the state
    final productState = container.read(productViewModelProvider);

    // check the state
    expect(productState.isLoading, false);
    expect(productState.hasReachedMax, false);
    expect(productState.products, products);
  });

  // Test resetState
  test('reset state and get products by category', () async {
    when(mockProductUsecase.getProductsByCategory(1, 2, "All", ""))
        .thenAnswer((_) => Future.value(Right(products)));

    // Test resetState
    await container.read(productViewModelProvider.notifier).resetState('All');

    // store the state
    final productState = container.read(productViewModelProvider);

    // check the state
    expect(productState.isLoading, false);
    expect(productState.hasReachedMax, false);
    expect(productState.products, products);
  });

  //Test searchProduct

  test('search product and return true if successfully get', () async {
    // Mock the getProductsByCategory method with any combination of arguments
    when(mockProductUsecase.getProductsByCategory(any, any, any, any))
        .thenAnswer((_) => Future.value(Right(products)));

    // Test searchProduct
    await container
        .read(productViewModelProvider.notifier)
        .searchProducts('All', 'KeharOjha');

    // Store the state
    final productState = container.read(productViewModelProvider);

    // Check the state
    expect(productState.isLoading, false);
    expect(productState.hasReachedMax, false);
    expect(productState.products, products);
  });

  tearDown(() {
    container.dispose();
  });
}
