import 'package:final_assignment/features/product/domain/entity/product_entity.dart';
import 'package:final_assignment/features/wishlist/domain/entity/wishlist_entity.dart';

class FavouritesEntityData {
  FavouritesEntityData._(); // Private constructor to prevent instantiation

  static List<WishlistEntity> getFavouriteTestData() {
    List<WishlistEntity> favourites = [
      WishlistEntity(
        id: '1',
        userId: 'user123',
        productId: const ProductEntity(
          id: 'product123',
          productName: 'Product A',
          productPrice: 100,
          productImage: 'image_url_1',
          productDescription: 'Description of Product A',
          productCategory: 'Category A',
          productQuantity: 10,
        ),
      ),
      WishlistEntity(
        id: '2',
        userId: 'user124',
        productId: const ProductEntity(
          id: 'product124',
          productName: 'Product B',
          productPrice: 200,
          productImage: 'image_url_2',
          productDescription: 'Description of Product B',
          productCategory: 'Category B',
          productQuantity: 5,
        ),
      ),
      WishlistEntity(
        id: '3',
        userId: 'user125',
        productId: const ProductEntity(
          id: 'product125',
          productName: 'Product C',
          productPrice: 300,
          productImage: 'image_url_3',
          productDescription: 'Description of Product C',
          productCategory: 'Category C',
          productQuantity: 2,
        ),
      ),
    ];
    return favourites;
  }
}
