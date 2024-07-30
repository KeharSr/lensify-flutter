import 'package:final_assignment/app/constants/colors.dart';
import 'package:final_assignment/core/common/widgets/my_carousel_slider.dart';
import 'package:final_assignment/core/common/widgets/my_vertical_product_cart.dart';
import 'package:final_assignment/core/common/widgets/t_app_bar.dart';
import 'package:final_assignment/core/common/widgets/t_curved_edges_widget.dart';
import 'package:final_assignment/core/common/widgets/t_search_container.dart';
import 'package:final_assignment/features/cart/presentation/viewmodel/cart_view_model.dart';
import 'package:final_assignment/features/feedback/presentation/viewmodel/feedback_viewmodel.dart';
import 'package:final_assignment/features/product/presentation/view_model/products_viewmodel.dart';
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
  void initState() {
    super.initState();
    ref.read(feedbackViewModelProvider.notifier).startListeningToGyroscope();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    ref.read(feedbackViewModelProvider.notifier).stopListeningToGyroscope();
    super.dispose();
  }

  int index = 0;

  @override
  Widget build(BuildContext context) {
    final productState = ref.watch(productViewModelProvider);

    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        body: NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification is ScrollEndNotification &&
                _scrollController.position.extentAfter == 0) {
              ref
                  .read(productViewModelProvider.notifier)
                  .getProductsByCategory(index == 0
                      ? 'All'
                      : index == 1
                          ? 'Sun Glasses'
                          : 'Power Glasses');
            }
            return true;
          },
          child: RefreshIndicator(
            onRefresh: () async {
              ref.read(productViewModelProvider.notifier).resetState(index == 0
                  ? 'All'
                  : index == 1
                      ? 'Sun Glasses'
                      : 'Power Glasses');
            },
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  TCurvedEdgeWidget(
                    child: Container(
                      height: 300,
                      color: TColors.primary,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 1.0),
                        child: Column(
                          children: [
                            TAppBar(onPressed: () {
                              ref
                                  .read(productViewModelProvider.notifier)
                                  .openCartView();
                            }),
                            const SizedBox(height: 16),
                            const TSearchContainer(
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
                            const SizedBox(height: 8),
                            TabBar(
                              onTap: (i) {
                                setState(() {
                                  index = i;
                                });
                                ref
                                    .read(productViewModelProvider.notifier)
                                    .resetState(index == 0
                                        ? 'All'
                                        : index == 1
                                            ? 'Sun Glasses'
                                            : 'Power Glasses');
                              },
                              tabs: const [
                                Tab(text: 'All'),
                                Tab(text: 'Sun Glasses'),
                                Tab(text: 'Power Glasses'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // const MyCarouselSlider(),
                  MyCarouselSlider(),
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
                          itemCount: productState.products.length,
                          itemBuilder: (context, index) {
                            final product = productState.products[index];
                            return MyProductCard(
                              product: product,
                              onPressed: () {
                                ref
                                    .read(cartViewModelProvider.notifier)
                                    .addCart(product.id!, 1);
                              },
                            );
                          },
                        ),
                        if (productState.isLoading)
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
      ),
    );
  }
}
