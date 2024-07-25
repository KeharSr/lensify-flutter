import 'package:final_assignment/features/product/domain/entity/product_entity.dart';

class ProductTestData {
  ProductTestData._();

  static List<ProductEntity> getProductTestData() {
    List<ProductEntity> products = [
      const ProductEntity(
          id: '66881b58d7263074b6405d66',
          productName: 'KeharOjha',
          productPrice: 12000,
          productImage:
              'DALL·E 2024-07-05 17.36.26 - A logo inspired by WhatsApp with a blurred effect. The logo should feature a speech bubble with a telephone icon inside it, resembling the classic Wha.webp',
          productDescription: 'fhvvhjb ln',
          productCategory: 'Sun Glasses',
          productQuantity: 1),
      const ProductEntity(
          id: '6689055d97af5f947abaa8aa',
          productName: 'kehar2',
          productPrice: 12000,
          productImage:
              '1720255837242_448633970_1573378216555627_8748640651415185141_n.png',
          productDescription: 'this is the new product',
          productCategory: 'Sun Glasses',
          productQuantity: 1),
    ];

    return products;
  }
}
