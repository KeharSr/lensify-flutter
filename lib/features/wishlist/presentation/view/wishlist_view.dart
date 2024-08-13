import 'package:final_assignment/app/constants/api_endpoint.dart';
import 'package:final_assignment/app/constants/colors.dart';
import 'package:final_assignment/app/constants/sizes.dart';
import 'package:final_assignment/features/wishlist/presentation/view_model/wishlist_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

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
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        title: const Text(
          "Wishlist",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: wishlistState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : wishlistState.favorites.isEmpty
              ? const Center(child: Text("No favorite items found"))
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: TSizes.sm),
                  child: GridView.builder(
                    itemCount: wishlistState.favorites.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: TSizes.sm,
                      mainAxisSpacing: TSizes.sm,
                      childAspectRatio: 0.75,
                    ),
                    itemBuilder: (context, index) {
                      final favoriteItems = wishlistState.favorites[index];
                      final imageUrl =
                          '${ApiEndpoints.imageUrl}${favoriteItems.productId!.productImage}';

                      return Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(TSizes.md),
                              color: theme.cardColor,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(TSizes.sm),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(TSizes.md),
                                      child: Image.network(
                                        imageUrl,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: TSizes.xs),
                                  Text(
                                    favoriteItems.productId!.productName,
                                    style: theme.textTheme.titleLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: TSizes.xs),
                                  Text(
                                    favoriteItems.productId!.productCategory,
                                    style: theme.textTheme.titleLarge?.copyWith(
                                      color: theme.textTheme.titleLarge?.color
                                          ?.withOpacity(0.6),
                                    ),
                                  ),
                                  const SizedBox(height: TSizes.sm),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "\$${favoriteItems.productId!.productPrice}",
                                        style: theme.textTheme.titleLarge
                                            ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: theme.cardColor,
                                          borderRadius: const BorderRadius.only(
                                            bottomRight:
                                                Radius.circular(TSizes.md),
                                            topLeft: Radius.circular(TSizes.md),
                                          ),
                                        ),
                                        child: IconButton(
                                          icon:
                                              const Icon(Iconsax.shopping_bag),
                                          color: TColors.primary,
                                          onPressed: () {
                                            // Add to cart action
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Add the delete button
                          Positioned(
                            bottom: 60,
                            right: 20,
                            child: GestureDetector(
                              onTap: () {
                                ref
                                    .read(wishlistViewModelProvider.notifier)
                                    .removeWishlist(favoriteItems.id!);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.red.withOpacity(0.8),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Iconsax.trash,
                                  color: TColors.primary,
                                  size: TSizes.iconSm,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
    );
  }
}
