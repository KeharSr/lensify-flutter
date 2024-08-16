import 'dart:async';
import 'dart:math';

import 'package:final_assignment/app/constants/colors.dart';
import 'package:final_assignment/core/common/provider/internet_connectivity.dart';
import 'package:final_assignment/core/common/widgets/my_carousel_slider.dart';
import 'package:final_assignment/core/common/widgets/t_app_bar.dart';
import 'package:final_assignment/core/common/widgets/t_curved_edges_widget.dart';
import 'package:final_assignment/core/common/widgets/t_search_container.dart';
import 'package:final_assignment/features/cart/presentation/viewmodel/cart_view_model.dart';
import 'package:final_assignment/features/product/presentation/view_model/products_viewmodel.dart';
import 'package:final_assignment/features/product/presentation/widgets/my_vertical_product_cart.dart';
import 'package:final_assignment/features/profile/presentation/viewmodel/current_user_view_model.dart';
import 'package:final_assignment/features/single_product/presentation/view_model/single_product_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sensors_plus/sensors_plus.dart';

import '../../../wishlist/presentation/view_model/wishlist_view_model.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  final ScrollController _scrollController = ScrollController();
  int index = 0;

  // Variables for shake detection
  static const double shakeThreshold = 15.0;
  static const int shakeTimeoutMs = 500;
  int lastShakeTimestamp = DateTime.now().millisecondsSinceEpoch;
  StreamSubscription? _accelerometerSubscription;

  @override
  void initState() {
    super.initState();

    // Start listening to accelerometer events
    _startListeningToShakeEvents();

    // Fetch products and their ratings
    Future.microtask(() async {
      await _fetchProducts();
    });
  }

  void _startListeningToShakeEvents() {
    _accelerometerSubscription =
        accelerometerEvents.listen((AccelerometerEvent event) {
      final int currentTime = DateTime.now().millisecondsSinceEpoch;

      if (currentTime - lastShakeTimestamp > shakeTimeoutMs) {
        final double acceleration = sqrt(
          event.x * event.x + event.y * event.y + event.z * event.z,
        );

        if (acceleration > shakeThreshold) {
          lastShakeTimestamp = currentTime;
          _logout();
        }
      }
    });
  }

  Future<void> _fetchProducts() async {
    final isConnected = ref.watch(connectivityStatusProvider);
    if (isConnected == ConnectivityStatus.isConnected) {
      // Online mode: fetch from remote source
      await ref
          .read(productViewModelProvider.notifier)
          .getProductsByCategory('All');
    } else {
      // Offline mode: fetch from local storage (Hive)
      await ref.read(productViewModelProvider.notifier).getProductFromHive();
    }

    // Fetch ratings for products
    final productState = ref.read(productViewModelProvider);
    final singleProductViewModel =
        ref.read(singleProductViewModelProvider.notifier);

    if (productState.products.isNotEmpty) {
      for (final product in productState.products) {
        await singleProductViewModel.getRatingReview(product.id!);
      }
    }
  }

  void _logout() {
    ref.read(currentUserViewModelProvider.notifier).logout();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _accelerometerSubscription
        ?.cancel(); // Cancel the accelerometer subscription
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productState = ref.watch(productViewModelProvider);
    final ratingReviewState = ref.watch(singleProductViewModelProvider);
    final conectivityState = ref.watch(connectivityStatusProvider);

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
            onRefresh: _fetchProducts,
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
                            // Retry button

                            const SizedBox(height: 16),
                            TSearchContainer(
                              text: 'Search for products',
                              icon: Icons.search,
                              onChanged: (value) {
                                ref
                                    .read(productViewModelProvider.notifier)
                                    .searchProducts(
                                        index == 0
                                            ? 'All'
                                            : index == 1
                                                ? 'Sun Glasses'
                                                : 'Power Glasses',
                                        value);
                              },
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
                  const MyCarouselSlider(),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (conectivityState != ConnectivityStatus.isConnected)
                          const Center(
                            child: Text(
                              'You are viewing offline data',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        const SizedBox(height: 8),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                                MediaQuery.of(context).size.width > 600 ? 3 : 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            childAspectRatio: 0.75,
                            mainAxisExtent: 265,
                          ),
                          itemCount: productState.products.length,
                          itemBuilder: (context, index) {
                            final product = productState.products[index];
                            final ratingReview = ratingReviewState.reviews
                                .where((element) =>
                                    element.productId == product.id)
                                .toList();

                            final averageRating = ratingReview.isNotEmpty
                                ? ratingReview
                                        .map((e) => e.rating)
                                        .reduce((a, b) => a + b) /
                                    ratingReview.length
                                : 0.0;

                            return MyProductCard(
                              product: product,
                              rating: averageRating,
                              onPressed: () {
                                ref
                                    .read(cartViewModelProvider.notifier)
                                    .addCart(product.id!, 1);
                              },
                              onWishlistTap: () {
                                ref
                                    .read(wishlistViewModelProvider.notifier)
                                    .addWishlist(product.id!);
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
