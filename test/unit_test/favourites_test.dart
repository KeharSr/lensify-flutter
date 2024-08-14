import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/shared_prefs/user_shared_prefs.dart';
import 'package:final_assignment/features/wishlist/domain/entity/wishlist_entity.dart';
import 'package:final_assignment/features/wishlist/domain/usecase/wishlist_usecase.dart';
import 'package:final_assignment/features/wishlist/presentation/view_model/wishlist_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../test_data/favourites_entity_data.dart'; // Ensure this is imported for test data
import 'favourites_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<WishlistUsecase>(),
])
Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  late WishlistUsecase mockWishlistUsecase;
  late ProviderContainer container;
  late UserSharedPrefs mockUserSharedPrefs;
  late List<WishlistEntity> wishlist;

  setUp(() {
    mockWishlistUsecase = MockWishlistUsecase();
    mockUserSharedPrefs = UserSharedPrefs();
    wishlist =
        FavouritesEntityData.getFavouriteTestData(); // Initialize the wishlist
    container = ProviderContainer(
      overrides: [
        wishlistViewModelProvider.overrideWith(
          (ref) => WishlistViewModel(
            wishlistUseCase: mockWishlistUsecase,
            userSharedPrefs: mockUserSharedPrefs,
          ),
        ),
      ],
    );
  });

  test('check for the initial state in Wishlist State', () {
    final wishlistState = container.read(wishlistViewModelProvider);
    expect(wishlistState.isLoading, false);
    expect(wishlistState.error, isNull);
    expect(wishlistState.favorites, isEmpty);
  });

  // Test getWishlist
  test('test wishlist and return success if successfully get', () async {
    when(mockWishlistUsecase.getWishlist()).thenAnswer((_) =>
        Future.value(Right(wishlist))); // Correct the missing parenthesis

    await container.read(wishlistViewModelProvider.notifier).getWishlist();

    final wishlistState = container.read(wishlistViewModelProvider);

    expect(wishlistState.isLoading, false);
    expect(wishlistState.error, isNull);
    expect(wishlistState.favorites, wishlist); // Ensure it matches the wishlist
  });

  // Test addWishlist
  test('test wishlist and return success if successfully added', () async {
    when(mockWishlistUsecase.addWishlist('1'))
        .thenAnswer((_) => Future.value(Right(true)));

    await container.read(wishlistViewModelProvider.notifier).addWishlist('1');

    final wishlistState = container.read(wishlistViewModelProvider);

    expect(wishlistState.isLoading, false);
    expect(wishlistState.error, isNull);
  });


  // Test removeWishlist
  test('test wishlist and return success if successfully removed', () async {
    const productId = '123'; // Example product ID

    // Mock the removeWishlist use case
    when(mockWishlistUsecase.removeWishlist(productId))
        .thenAnswer((_) async => const Right(true));

    // Mock the getWishlist use case
    when(mockWishlistUsecase.getWishlist())
        .thenAnswer((_) async => Right(wishlist));

    // Act
    await container
        .read(wishlistViewModelProvider.notifier)
        .removeWishlist(productId);

    final wishlistState = container.read(wishlistViewModelProvider);

    // Assert
    expect(wishlistState.isLoading, isFalse); // Ensure loading is false
    expect(wishlistState.error, isNull); // Ensure there is no error
    expect(wishlistState.favorites,
        wishlist); // Ensure wishlist is updated correctly
  });

  tearDown(() {
    container.dispose();
  });
}
