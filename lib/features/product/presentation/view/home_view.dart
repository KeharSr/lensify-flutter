// // import 'package:final_assignment/app/constants/sizes.dart';
// // import 'package:final_assignment/core/common/widgets/t_app_bar.dart';
// // import 'package:final_assignment/core/common/widgets/t_primary_header_container.dart';
// // import 'package:final_assignment/core/common/widgets/t_search_container.dart';
// // import 'package:flutter/material.dart';
// //
// // class HomeView extends StatelessWidget {
// //   const HomeView({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //         body: SingleChildScrollView(
// //       child: Column(
// //         children: [
// //           TPrimaryHeaderContainer(
// //             child: Column(
// //               children: [
// //                 TAppBar(),
// //                 const SizedBox(height: TSizes.spaceBtwSections),
// //
// //                 // Search bar
// //                 Row(
// //                   children: [
// //                     TSearchContainer(
// //                       text: 'Search in Store',
// //                     ),
// //                   ],
// //                 ),
// //                 SizedBox(height: TSizes.spaceBtwSections),
// //
// //                 // Categories
// //                 Padding(
// //                   padding: const EdgeInsets.only(left: TSizes.defaultSpace),
// //                   child: Column(
// //                     children: [
// //                       Text(
// //                         'Categories',
// //                         style: Theme.of(context).textTheme.headlineSmall!,
// //                         maxLines: 1,
// //                         overflow: TextOverflow.ellipsis,
// //                       ),
// //                       TextButton(
// //                           onPressed: () {}, child: const Text('See all')),
// //                     ],
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //           Padding(
// //             padding: const EdgeInsets.all(TSizes.defaultSpace),
// //             child: Container(
// //               decoration: BoxDecoration(
// //                 borderRadius: BorderRadius.circular(TSizes.md),
// //               ),
// //               child: ClipRRect(
// //                 borderRadius: BorderRadius.circular(TSizes.md),
// //                 child: Image(
// //                   image: NetworkImage(
// //                     "https://png.pngtree.com/png-clipart/20221126/ourmid/pngtree-palm-tree-sunglasses-beach-sunglasses-png-image_6480557.png",
// //                   ),
// //                   fit: BoxFit.contain,
// //                 ),
// //               ),
// //             ),
// //           )
// //         ],
// //       ),
// //     ));
// //   }
// // }
//
// import 'package:final_assignment/app/constants/sizes.dart';
// import 'package:final_assignment/core/common/widgets/t_app_bar.dart';
// import 'package:final_assignment/core/common/widgets/t_primary_header_container.dart';
// import 'package:final_assignment/core/common/widgets/t_search_container.dart';
// import 'package:flutter/material.dart';
//
// class HomeView extends StatelessWidget {
//   const HomeView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             TPrimaryHeaderContainer(
//               child: Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
//                 child: Column(
//                   children: [
//                     TAppBar(
//                       onPressed: () {
//                         ref
//                             .read(productViewModelProvider.notifier)
//                             .getProducts();
//                       },
//                     ),
//                     const SizedBox(height: TSizes.spaceBtwSections),
//
//                     // Search bar
//                     Row(
//                       children: [
//                         Expanded(
//                           child: TSearchContainer(
//                             text: 'Search in Store',
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: TSizes.spaceBtwSections),
//
//                     // Categories
//                     Padding(
//                       padding: const EdgeInsets.only(left: TSizes.defaultSpace),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             'Categories',
//                             style: Theme.of(context).textTheme.headlineSmall!,
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                           TextButton(
//                             onPressed: () {},
//                             child: const Text('See all'),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             // Padding(
//             //   padding: EdgeInsets.all(TSizes.defaultSpace),
//             //   child: Container(
//             //       decoration: BoxDecoration(
//             //         borderRadius: BorderRadius.circular(TSizes.md),
//             //       ),
//             //       child: Column(
//             //         children: [
//             //           CarouselSlider(
//             //             options: CarouselOptions(viewportFraction: 0.8),
//             //             items: [
//             //               ClipRRect(
//             //                 borderRadius: BorderRadius.circular(TSizes.md),
//             //                 child: Image(
//             //                   image: NetworkImage(
//             //                     "https://via.placeholder.com/400x300.png", // Replace with a valid URL
//             //                   ),
//             //                   fit: BoxFit.contain,
//             //                 ),
//             //               ),
//             //             ],
//             //           ),
//             //           const SizedBox(height: TSizes.spaceBtwItems),
//             //           Row(
//             //             children: [
//             //               for (int i = 0; i < 3; i++)
//             //                 TCircularContainer(
//             //                   width: 20,
//             //                   height: 4,
//             //                   margin: EdgeInsets.only(right: 10),
//             //                   backgroundColor: Colors.green,
//             //                 ),
//             //             ],
//             //           )
//             //         ],
//             //       )),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }
