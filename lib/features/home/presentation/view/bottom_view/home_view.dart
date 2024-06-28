

import 'package:carousel_slider/carousel_slider.dart';
import 'package:final_assignment/core/common/widgets/curved_edges.dart';
import 'package:final_assignment/core/common/widgets/my_appbar.dart';
import 'package:final_assignment/core/common/widgets/my_product_cart.dart';
import 'package:final_assignment/core/common/widgets/my_search_container.dart';
import 'package:final_assignment/features/home/presentation/viewmodel/products_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productViewModelProvider);

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollEndNotification &&
            _scrollController.position.extentAfter == 0) {
          ref.read(productViewModelProvider.notifier).getProducts();
        }
        return true;
      },
      child: Scaffold(
        body: Column(
          children: [
            ClipPath(
              clipper: TCurvedEdges(),
              child: Container(
                height: 300,
                color: Colors.blue,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 1.0,
                  ),
                  child: Column(
                    children: [
                      MyAppbar(
                        title: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Lets Shop',
                              style: TextStyle(
                                color: Color.fromARGB(255, 222, 15, 15),
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              'Kehar Sr',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        actions: [
                          Stack(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.shopping_cart_rounded,
                                  color: Colors.white,
                                ),
                              ),
                              Positioned(
                                right: 0,
                                child: Container(
                                  width: 18,
                                  height: 18,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      '2',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const MySearchContainer(
                        text: 'Search for products',
                        icon: Icons.search,
                      ),
                      const SizedBox(height: 16),
                      const Padding(
                        padding: EdgeInsets.only(left: 35, top: 5),
                        child: Row(
                          children: [
                            Text(
                              'Categories',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                          height: 200,
                          autoPlay: true,
                          enlargeCenterPage: true,
                          aspectRatio: 2.0,
                          onPageChanged: (index, reason) {
                            // Optional: Handle carousel page change
                          },
                        ),
                        items: [
                          'https://via.placeholder.com/300',
                          'https://via.placeholder.com/300',
                          'https://via.placeholder.com/300',
                        ].map((imageUrl) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: const BoxDecoration(
                                  color: Colors.amber,
                                ),
                                child: Image.network(
                                  imageUrl,
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 16),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: 0.75, // Adjust this as needed
                        ),
                        itemCount: state.products.length,
                        itemBuilder: (context, index) {
                          final product = state.products[index];
                          return MyProductCard(
                              product: product); 
                        },
                      ),
                      if (state.isLoading)
                        const Center(
                          child: CircularProgressIndicator(
                            color: Colors.red,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}




// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:final_assignment/app/constants/api_endpoint.dart';
// import 'package:final_assignment/core/common/widgets/curved_edges.dart';
// import 'package:final_assignment/core/common/widgets/my_appbar.dart';
// import 'package:final_assignment/core/common/widgets/my_search_container.dart';
// import 'package:final_assignment/features/home/presentation/viewmodel/products_viewmodel.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class HomeView extends ConsumerStatefulWidget {
//   const HomeView({super.key});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
// }

// class _HomeViewState extends ConsumerState<HomeView> {
//   final ScrollController _scrollController = ScrollController();

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final state = ref.watch(productViewModelProvider);

//     return NotificationListener<ScrollNotification>(
//       onNotification: (notification) {
//         if (notification is ScrollEndNotification &&
//             _scrollController.position.extentAfter == 0) {
//           ref.read(productViewModelProvider.notifier).getProducts();
//         }
//         return true;
//       },
//       child: Scaffold(
//         body: Column(
//           children: [
//             ClipPath(
//               clipper: TCurvedEdges(),
//               child: Container(
//                 height: 300,
//                 color: Colors.blue,
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 1.0,
//                   ),
//                   child: Column(
//                     children: [
//                       MyAppbar(
//                         title: const Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Lets Shop',
//                               style: TextStyle(
//                                 color: Color.fromARGB(255, 222, 15, 15),
//                                 fontSize: 20,
//                               ),
//                             ),
//                             Text(
//                               'Kehar Sr',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 12,
//                               ),
//                             ),
//                           ],
//                         ),
//                         actions: [
//                           Stack(
//                             children: [
//                               IconButton(
//                                 onPressed: () {},
//                                 icon: const Icon(
//                                   Icons.shopping_cart_rounded,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                               Positioned(
//                                 right: 0,
//                                 child: Container(
//                                   width: 18,
//                                   height: 18,
//                                   decoration: BoxDecoration(
//                                     color: Colors.black.withOpacity(0.5),
//                                     borderRadius: BorderRadius.circular(50),
//                                   ),
//                                   child: const Center(
//                                     child: Text(
//                                       '2',
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 12,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 16),
//                       const MySearchContainer(
//                         text: 'Search for products',
//                         icon: Icons.search,
//                       ),
//                       const SizedBox(height: 16),
//                       const Padding(
//                         padding: EdgeInsets.only(left: 35, top: 5),
//                         child: Row(
//                           children: [
//                             Text(
//                               'Categories',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 24,
//                               ),
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: SingleChildScrollView(
//                 controller: _scrollController,
//                 child: Container(
//                   color: Colors.white,
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       CarouselSlider(
//                         options: CarouselOptions(
//                           height: 200,
//                           autoPlay: true,
//                           enlargeCenterPage: true,
//                           aspectRatio: 2.0,
//                           onPageChanged: (index, reason) {
//                             // Optional: Handle carousel page change
//                           },
//                         ),
//                         items: [
//                           'https://via.placeholder.com/300',
//                           'https://via.placeholder.com/300',
//                           'https://via.placeholder.com/300',
//                         ].map((imageUrl) {
//                           return Builder(
//                             builder: (BuildContext context) {
//                               return Container(
//                                 width: MediaQuery.of(context).size.width,
//                                 margin:
//                                     const EdgeInsets.symmetric(horizontal: 5.0),
//                                 decoration: const BoxDecoration(
//                                   color: Colors.amber,
//                                 ),
//                                 child: Image.network(
//                                   imageUrl,
//                                   fit: BoxFit.cover,
//                                 ),
//                               );
//                             },
//                           );
//                         }).toList(),
//                       ),
//                       const SizedBox(height: 16),
//                       GridView.builder(
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                         gridDelegate:
//                             const SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: 2,
//                           crossAxisSpacing: 8,
//                           mainAxisSpacing: 8,
//                           childAspectRatio: 0.75, // Adjust this as needed
//                         ),
//                         itemCount: state.products.length,
//                         itemBuilder: (context, index) {
//                           final product = state.products[index];
//                           final imageUrl =
//                               '${ApiEndpoints.imageUrl}${product.productImage}';

//                           return Container(
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(16),
//                               boxShadow: const [
//                                 BoxShadow(
//                                   color: Colors.black12,
//                                   blurRadius: 4,
//                                   spreadRadius: 2,
//                                 ),
//                               ],
//                             ),
//                             child: Stack(
//                               children: [
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Expanded(
//                                       child: ClipRRect(
//                                         borderRadius: const BorderRadius.only(
//                                           topLeft: Radius.circular(16),
//                                           topRight: Radius.circular(16),
//                                         ),
//                                         child: Image.network(
//                                           imageUrl,
//                                           fit: BoxFit.cover,
//                                           width: double.infinity,
//                                           height: double.infinity,
//                                         ),
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.all(8),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             product.productName,
//                                             style: const TextStyle(
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                           ),
//                                           const SizedBox(height: 4),
//                                           Text(
//                                             product.productDescription,
//                                             style: const TextStyle(
//                                               fontSize: 14,
//                                               color: Colors.grey,
//                                             ),
//                                           ),
//                                           const SizedBox(height: 4),
//                                           Text(
//                                             product.productCategory,
//                                             style: const TextStyle(
//                                               fontSize: 14,
//                                               color: Colors.grey,
//                                             ),
//                                           ),
//                                           Text(
//                                             product.productPrice.toString(),
//                                             style: const TextStyle(
//                                               fontSize: 14,
//                                               color: Colors.grey,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Positioned(
//                                   top: 0,
//                                   right: 0,
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(1),
//                                     child: IconButton(
//                                       icon: const Icon(
//                                         Icons.favorite_border,
//                                         color: Colors.red,
//                                       ),
//                                       onPressed: () {
//                                         // Add your favorite button logic here
//                                       },
//                                     ),
//                                   ),
//                                 ),
//                                 Positioned(
//                                   bottom: 0,
//                                   right: 0,
//                                   child: IconButton(
//                                     icon: const Icon(
//                                       Icons.add_shopping_cart,
//                                       color: Colors.blue,
//                                     ),
//                                     onPressed: () {
//                                       // Add your add to cart button logic here
//                                     },
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           );
//                         },
//                       ),
//                       if (state.isLoading)
//                         const Center(
//                           child: CircularProgressIndicator(
//                             color: Colors.red,
//                           ),
//                         ),
//                     ],
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
