import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/shared_prefs/user_shared_prefs.dart';
import 'package:final_assignment/features/home/domain/entity/product_entity.dart';
import 'package:final_assignment/features/home/domain/usecases/product_usecase.dart';
import 'package:final_assignment/features/home/presentation/navigator/home_navigator.dart';
import 'package:final_assignment/features/home/presentation/viewmodel/products_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'product_entity_data.dart';
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

  // Test initial state

  test('check product initial state', () async {
    when(mockProductUsecase.pagination(1, 2))
        .thenAnswer((_) => Future.value(Right(products)));

    // Test getProducts
    await container.read(productViewModelProvider.notifier).getProducts();

    // store the state
    final productState = container.read(productViewModelProvider);

    // check the state
    expect(productState.isLoading, false);
    expect(productState.hasReachedMax, false);
    expect(productState.products, products);
  });

  // Test getProducts
  test('get product entity and return true if sucessfully get', () async {
    when(mockProductUsecase.pagination(1, 2))
        .thenAnswer((_) => Future.value(Right(products)));

    // Test getProducts
    await container.read(productViewModelProvider.notifier).getProducts();

    // store the state
    final productState = container.read(productViewModelProvider);

    // check the state
    expect(productState.isLoading, false);
    expect(productState.hasReachedMax, false);
    expect(productState.products, products);
  });

  tearDown(() {
    container.dispose();
  });
}
