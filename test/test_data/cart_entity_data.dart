import 'package:final_assignment/features/cart/domain/entity/cart_entity.dart';
import 'package:final_assignment/features/product/domain/entity/product_entity.dart';

class CartTestData {
  CartTestData._(); // Private constructor to prevent instantiation

  static List<CartEntity> getCartTestData() {
    List<CartEntity> carts = [
      const CartEntity(
        id: '66881b58d7263074b6405d66',
        userId: 'user123',
        productId: ProductEntity(
          id: 'product123',
          productName: 'KeharOjha',
          productPrice: 12000,
          productImage: 'image_url_1',
          productDescription: 'Product Description 1',
          productCategory: 'Sun Glasses',
          productQuantity: 3,
        ),
        quantity: 1,
        status: 'active',
      ),
      const CartEntity(
        id: '6689055d97af5f947abaa8aa',
        userId: 'user124',
        productId: ProductEntity(
            id: 'product124',
            productName: 'kehar2',
            productPrice: 1200,
            productImage: 'image_url_2',
            productDescription: 'Product Description 2',
            productCategory: 'Sun Glasses',
            productQuantity: 5),
        quantity: 2,
        status: 'active',
      ),
      const CartEntity(
        id: '1234567890abcdef',
        userId: 'user125',
        productId: ProductEntity(
          id: 'product125',
          productName: 'RayBan Aviator',
          productPrice: 15000,
          productImage: 'image_url_3',
          productDescription: 'Stylish sunglasses from RayBan.',
          productCategory: 'Sun Glasses',
          productQuantity: 1,
        ),
        quantity: 1,
        status: 'active',
      ),
      const CartEntity(
        id: '0987654321fedcba',
        userId: 'user126',
        productId: ProductEntity(
          id: 'product126',
          productName: 'Apple Watch',
          productPrice: 2500,
          productImage: 'image_url_4',
          productDescription: 'Smartwatch from Apple with many features.',
          productCategory: 'Watches',
          productQuantity: 1,
        ),
        quantity: 1,
        status: 'active',
      ),
    ];
    return carts;
  }
}
