import 'package:final_assignment/core/common/widgets/my_appbar.dart';
import 'package:final_assignment/core/common/widgets/my_carousel_slider.dart';
import 'package:final_assignment/core/common/widgets/my_curved_edges.dart';
import 'package:final_assignment/core/common/widgets/my_search_container.dart';
import 'package:final_assignment/core/common/widgets/my_vertical_product_cart.dart';
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

    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollEndNotification &&
              _scrollController.position.extentAfter == 0) {
            ref.read(productViewModelProvider.notifier).getProducts();
          }
          return true;
        },
        child: RefreshIndicator(
          onRefresh: () async {
            ref.read(productViewModelProvider.notifier).resetState();
          },
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                ClipPath(
                  clipper: MyCurvedEdges(),
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
                const MyCarouselSlider(),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
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
                          return MyProductCard(product: product);
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
