import 'package:final_assignment/app/constants/api_endpoint.dart';
import 'package:final_assignment/app/constants/colors.dart';
import 'package:final_assignment/features/wishlist/presentation/view_model/wishlist_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteView extends ConsumerStatefulWidget {
  const FavoriteView({super.key});

  @override
  ConsumerState<FavoriteView> createState() => _FavoriteState();
}

class _FavoriteState extends ConsumerState<FavoriteView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => ref.read(wishlistViewModelProvider.notifier).getWishlist());
  }

  @override
  Widget build(BuildContext context) {
    final wishlistState = ref.watch(wishlistViewModelProvider);

    return Scaffold(
      backgroundColor: TColors.creamwhite,
      appBar: AppBar(
        backgroundColor: TColors.creamwhite,
        title: const Text(
          "Favorite",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: wishlistState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : wishlistState.favorites.isEmpty
              ? const Center(child: Text("No favorite items found"))
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: wishlistState.favorites.length,
                        itemBuilder: (context, index) {
                          final favoriteItems = wishlistState.favorites[index];
                          final imageUrl =
                              '${ApiEndpoints.imageUrl}${favoriteItems.productId!.productImage}';
                          return Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        width: 85,
                                        height: 85,
                                        decoration: BoxDecoration(
                                          color: TColors.creamwhite,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Image.network(imageUrl),
                                      ),
                                      const SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            favoriteItems
                                                .productId!.productName,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            favoriteItems
                                                .productId!.productCategory,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey.shade400,
                                              fontSize: 16,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            "\$${favoriteItems.productId!.productPrice}",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              // for delete button
                              Positioned(
                                top: 50,
                                right: 35,
                                child: GestureDetector(
                                  // onTap: () {
                                  //   ref
                                  //       .read(wishlistViewModelProvider.notifier)
                                  //       .removeFavorite(index);
                                  // },
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                    size: 25,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
    );
  }
}
