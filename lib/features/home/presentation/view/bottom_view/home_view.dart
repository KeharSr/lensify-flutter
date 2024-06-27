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
//     return NotificationListener(
//         onNotification: (notification) {
//           if (notification is ScrollEndNotification &&
//               _scrollController.position.extentAfter == 0) {
//             ref.read(productViewModelProvider.notifier).getProducts();
//           }
//           return true;
//         },
//         child: Scaffold(
//           body: SingleChildScrollView(
//             child: Column(
//               children: [
//                 ClipPath(
//                   clipper: TCurvedEdges(),
//                   child: Container(
//                     color: Colors.blue,
//                     padding: const EdgeInsets.all(0),
//                     child: Stack(
//                       children: [
//                         Positioned(
//                           child: Container(
//                             width: 400,
//                             height: 300,
//                             padding: const EdgeInsets.all(0),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(400),
//                               color: Colors.white.withOpacity(0.1),
//                             ),
//                           ),
//                         ),
//                         Positioned(
//                           child: Column(
//                             children: [
//                               MyAppbar(
//                                 title: const Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       'Lets Shop',
//                                       style: TextStyle(
//                                         color: Color.fromARGB(255, 222, 15, 15),
//                                         fontSize: 20,
//                                       ),
//                                     ),
//                                     Text(
//                                       'Kehar Sr',
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 12,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 actions: [
//                                   Stack(
//                                     children: [
//                                       IconButton(
//                                         onPressed: () {},
//                                         icon: const Icon(
//                                           Icons.shopping_cart_rounded,
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                       Positioned(
//                                         right: 0,
//                                         child: Container(
//                                           width: 18,
//                                           height: 18,
//                                           decoration: BoxDecoration(
//                                               color:
//                                                   Colors.black.withOpacity(0.5),
//                                               borderRadius:
//                                                   BorderRadius.circular(50)),
//                                           child: const Center(
//                                             child: Text(
//                                               '2',
//                                               style: TextStyle(
//                                                 color: Colors.white,
//                                                 fontSize: 12,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       )
//                                     ],
//                                   )
//                                 ],
//                               ),
//                               const SizedBox(height: 16),
//                               const MySearchContainer(
//                                 text: 'Search for products',
//                                 icon: Icons.search,
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(
//                                     right: 140, top: 16, left: 16),
//                                 child: Column(
//                                   children: [
//                                     Row(
//                                       children: [
//                                         const Text(
//                                           'Categories',
//                                           style: TextStyle(
//                                             color: Colors.white,
//                                             fontSize: 24,
//                                           ),
//                                           maxLines: 1,
//                                           overflow: TextOverflow.ellipsis,
//                                         ),
//                                         TextButton(
//                                           onPressed: () {},
//                                           child: const Text(
//                                             'View All',
//                                             style:
//                                                 TextStyle(color: Colors.white),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     // Product GridView
//                                     if (state.isLoading)
//                                       const CircularProgressIndicator(),
//                                     if (!state.isLoading &&
//                                         state.products.isNotEmpty)
//                                       GridView.builder(
//                                         shrinkWrap: true,
//                                         physics:
//                                             const AlwaysScrollableScrollPhysics(),
//                                         gridDelegate:
//                                             const SliverGridDelegateWithFixedCrossAxisCount(
//                                           crossAxisCount: 2,
//                                           crossAxisSpacing: 8,
//                                           mainAxisSpacing: 8,
//                                           childAspectRatio: 0.75,
//                                         ),
//                                         itemCount: state.products.length,
//                                         itemBuilder: (context, index) {
//                                           final product = state.products[index];
//                                           return Container(
//                                             decoration: BoxDecoration(
//                                               color: Colors.white,
//                                               borderRadius:
//                                                   BorderRadius.circular(16),
//                                             ),
//                                             child: Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 Expanded(
//                                                   child: Image.network(
//                                                     product.productImage,
//                                                     fit: BoxFit.cover,
//                                                   ),
//                                                 ),
//                                                 Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(8),
//                                                   child: Column(
//                                                     crossAxisAlignment:
//                                                         CrossAxisAlignment
//                                                             .start,
//                                                     children: [
//                                                       Text(
//                                                         product.productName,
//                                                         style: const TextStyle(
//                                                           fontSize: 16,
//                                                           fontWeight:
//                                                               FontWeight.bold,
//                                                         ),
//                                                       ),
//                                                       const SizedBox(height: 4),
//                                                       Text(
//                                                         product.productPrice,
//                                                         style: const TextStyle(
//                                                           fontSize: 14,
//                                                           color: Colors.grey,
//                                                         ),
//                                                       ),
//                                                       Text(
//                                                         product
//                                                             .productDescription,
//                                                         style: const TextStyle(
//                                                           fontSize: 14,
//                                                           color: Colors.grey,
//                                                         ),
//                                                       ),
//                                                       Text(
//                                                         product.productCategory,
//                                                         style: const TextStyle(
//                                                           fontSize: 14,
//                                                           color: Colors.grey,
//                                                         ),
//                                                       )
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           );
//                                         },
//                                       ),
//                                     if (!state.isLoading &&
//                                         state.products.isEmpty)
//                                       const Text('No products found'),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ));
//   }
// }



import 'package:final_assignment/core/common/widgets/curved_edges.dart';
import 'package:final_assignment/core/common/widgets/my_appbar.dart';
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

    
    return NotificationListener(
      onNotification: (notification) {
        if (notification is ScrollEndNotification &&
            _scrollController.position.extentAfter == 0) {
          ref.read(productViewModelProvider.notifier).getProducts();
        }
        return true;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              ClipPath(
                clipper: TCurvedEdges(),
                child: Container(
                  color: Colors.blue,
                  padding: const EdgeInsets.all(0),
                  child: Stack(
                    children: [
                      Positioned(
                        child: Container(
                          width: 400,
                          height: 300,
                          padding: const EdgeInsets.all(0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(400),
                            color: Colors.white.withOpacity(0.1),
                          ),
                        ),
                      ),
                      Positioned(
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
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            borderRadius:
                                                BorderRadius.circular(50)),
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
                                )
                              ],
                            ),
                            const SizedBox(height: 16),
                            const MySearchContainer(
                              text: 'Search for products',
                              icon: Icons.search,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 140, top: 16, left: 16),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      const Text(
                                        'Categories',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 24,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      TextButton(
                                        onPressed: () {},
                                        child: const Text(
                                          'View All',
                                          style:
                                              TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Product GridView
                                  if (state.isLoading)
                                    const CircularProgressIndicator(),
                                  if (!state.isLoading &&
                                      state.products.isNotEmpty)
                                    GridView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 8,
                                        mainAxisSpacing: 8,
                                        childAspectRatio: 0.75,
                                      ),
                                      itemCount: state.products.length,
                                      itemBuilder: (context, index) {
                                        final product = state.products[index];
                                        return Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Image.network(
                                                  product.productImage,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      product.productName,
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 4),
                                                    Text(
                                                      product.productPrice,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                    Text(
                                                      product
                                                          .productDescription,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                    Text(
                                                      product.productCategory,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.grey,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  if (!state.isLoading &&
                                      state.products.isEmpty)
                                    const Text('No products found'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
