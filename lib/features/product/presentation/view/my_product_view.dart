// import 'package:final_assignment/app/constants/api_endpoint.dart';
// import 'package:final_assignment/app/constants/colors.dart';
// import 'package:final_assignment/app/constants/sizes.dart';
// import 'package:final_assignment/core/common/widgets/my_rounded_image.dart';
// import 'package:final_assignment/core/common/widgets/productshadow.dart';
// import 'package:final_assignment/features/product/domain/entity/product_entity.dart';
// import 'package:flutter/material.dart';
// import 'package:iconsax/iconsax.dart';
//
// class MyProductView extends StatelessWidget {
//   final ProductEntity product;
//
//   const MyProductView({super.key, required this.product});
//
//   @override
//   Widget build(BuildContext context) {
//     final imageUrl = '${ApiEndpoints.imageUrl}${product.productImage}';
//     final dark = MediaQuery.of(context).platformBrightness == Brightness.dark;
//
//     return Container(
//       width: 190,
//       padding: const EdgeInsets.all(1),
//       decoration: BoxDecoration(
//         boxShadow: [TShadowStyle.verticalProductShadow],
//         borderRadius: BorderRadius.circular(TSizes.productImageRadius),
//         color: dark ? TColors.darkerGrey : TColors.white,
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Stack(
//             children: [
//               MyRoundedImage(
//                 imageUrl: imageUrl,
//                 width: double.infinity,
//                 height: 120,
//                 applyImageRadius: true,
//                 borderRadius: TSizes.productImageRadius,
//               ),
//               Positioned(
//                 right: 8,
//                 top: 8,
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(100),
//                     color: dark
//                         ? TColors.dark.withOpacity(0.5)
//                         : TColors.white.withOpacity(0.5),
//                   ),
//                   child: IconButton(
//                     onPressed: () {},
//                     icon: Icon(Iconsax.heart5),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 left: 8,
//                 top: 8,
//                 child: Container(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
//                   decoration: BoxDecoration(
//                     color: Colors.yellow,
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Text(
//                     '25%',
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 12,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   product.productName,
//                   style: Theme.of(context).textTheme.labelLarge,
//                   overflow: TextOverflow.ellipsis,
//                   maxLines: 1,
//                 ),
//                 Text(
//                   'Nike',
//                   style: Theme.of(context).textTheme.bodyMedium,
//                   overflow: TextOverflow.ellipsis,
//                   maxLines: 1,
//                 ),
//                 SizedBox(height: 1),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       '\$${product.productPrice}',
//                       style: Theme.of(context).textTheme.headlineSmall,
//                     ),
//                     IconButton(
//                       onPressed: () {},
//                       icon: Icon(Iconsax.add_square),
//                       color: Colors.black,
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
