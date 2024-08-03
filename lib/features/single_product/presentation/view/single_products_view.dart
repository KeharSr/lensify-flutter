// import 'package:final_assignment/features/cart/presentation/viewmodel/cart_view_model.dart';
// import 'package:final_assignment/features/single_product/presentation/view_model/single_product_view_model.dart';
// import 'package:final_assignment/features/single_product/presentation/widgets/product_details.dart';
// import 'package:final_assignment/features/wishlist/presentation/view_model/wishlist_view_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// class ProductViewPage extends ConsumerStatefulWidget {
//   final String productId;
//
//   const ProductViewPage({Key? key, required this.productId}) : super(key: key);
//
//   @override
//   _ProductViewPageState createState() => _ProductViewPageState();
// }
//
// class _ProductViewPageState extends ConsumerState<ProductViewPage> {
//   bool isDescriptionExpanded = false;
//   bool isReviewsExpanded = false;
//   List<String> reviews = ['Great product!', 'Love the color options.'];
//   TextEditingController reviewController = TextEditingController();
//
//   void addReview(String review) {
//     setState(() {
//       reviews.add(review);
//       reviewController.clear();
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchProductDetails();
//   }
//
//   void _fetchProductDetails() {
//     Future.microtask(() {
//       ref
//           .read(singleProductViewModelProvider.notifier)
//           .getSingleProduct(widget.productId);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final productState = ref.watch(singleProductViewModelProvider);
//
//     return Scaffold(
//       backgroundColor: Colors.grey[300],
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               // Header
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Icon(Icons.arrow_back),
//                     IconButton(
//                         onPressed: () {
//                           ref
//                               .read(wishlistViewModelProvider.notifier)
//                               .addWishlist(productState.singleProduct!.id!);
//                         },
//                         icon: Icon(Icons.favorite_border)),
//                   ],
//                 ),
//               ),
//
//               // Product Details
//               if (productState.singleProduct != null)
//                 ProductDetails(
//                   product: productState.singleProduct!,
//                   selectedQuantity: productState.selectedQuantity,
//                   isDescriptionExpanded: isDescriptionExpanded,
//                   onDescriptionToggle: () {
//                     setState(() {
//                       isDescriptionExpanded = !isDescriptionExpanded;
//                     });
//                   },
//                   isReviewsExpanded: isReviewsExpanded,
//                   onReviewsToggle: () {
//                     setState(() {
//                       isReviewsExpanded = !isReviewsExpanded;
//                     });
//                   },
//                   onDecreaseQuantity: () {
//                     ref
//                         .read(singleProductViewModelProvider.notifier)
//                         .updateSelectedQuantity(
//                             productState.selectedQuantity - 1);
//                   },
//                   onIncreaseQuantity: () {
//                     ref
//                         .read(singleProductViewModelProvider.notifier)
//                         .updateSelectedQuantity(
//                             productState.selectedQuantity + 1);
//                   },
//                   onCartPressed: () {
//                     ref.read(cartViewModelProvider.notifier).addCart(
//                         productState.singleProduct!.id!,
//                         productState.selectedQuantity);
//                   },
//                   reviews: reviews,
//                   reviewController: reviewController,
//                   addReview: addReview,
//                 ),
//               if (productState.isLoading)
//                 const Center(child: CircularProgressIndicator()),
//               if (productState.error != null)
//                 Center(child: Text(productState.error!)),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:final_assignment/features/cart/presentation/viewmodel/cart_view_model.dart';
// import 'package:final_assignment/features/ratingandreview/presentation/view_model/rating_review_view_model.dart';
// import 'package:final_assignment/features/single_product/presentation/view_model/single_product_view_model.dart';
// import 'package:final_assignment/features/single_product/presentation/widgets/product_details.dart';
// import 'package:final_assignment/features/wishlist/presentation/view_model/wishlist_view_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// class ProductViewPage extends ConsumerStatefulWidget {
//   final String productId;
//
//   const ProductViewPage({Key? key, required this.productId}) : super(key: key);
//
//   @override
//   _ProductViewPageState createState() => _ProductViewPageState();
// }
//
// class _ProductViewPageState extends ConsumerState<ProductViewPage> {
//   bool isDescriptionExpanded = false;
//   bool isReviewsExpanded = false;
//   List<String> reviews = ['Great product!', 'Love the color options.'];
//   TextEditingController reviewController = TextEditingController();
//   double rating = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchProductDetails();
//   }
//
//   void _fetchProductDetails() {
//     Future.microtask(() {
//       ref
//           .read(singleProductViewModelProvider.notifier)
//           .getSingleProduct(widget.productId);
//     });
//   }
//
//   void addReview(String review) {
//     ref
//         .read(ratingReviewViewModelProvider.notifier)
//         .addRatingReview(widget.productId, rating, review);
//     setState(() {
//       reviews.add(review);
//       reviewController.clear();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final productState = ref.watch(singleProductViewModelProvider);
//
//     return Scaffold(
//       backgroundColor: Colors.grey[300],
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               // Header
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     IconButton(
//                       icon: const Icon(Icons.arrow_back),
//                       onPressed: () => Navigator.of(context).pop(),
//                     ),
//                     IconButton(
//                         onPressed: () {
//                           ref
//                               .read(wishlistViewModelProvider.notifier)
//                               .addWishlist(productState.singleProduct!.id!);
//                         },
//                         icon: Icon(Icons.favorite_border)),
//                   ],
//                 ),
//               ),
//
//               // Product Details
//               if (productState.singleProduct != null)
//                 ProductDetails(
//                   product: productState.singleProduct!,
//                   selectedQuantity: productState.selectedQuantity,
//                   isDescriptionExpanded: isDescriptionExpanded,
//                   onDescriptionToggle: () {
//                     setState(() {
//                       isDescriptionExpanded = !isDescriptionExpanded;
//                     });
//                   },
//                   isReviewsExpanded: isReviewsExpanded,
//                   onReviewsToggle: () {
//                     setState(() {
//                       isReviewsExpanded = !isReviewsExpanded;
//                     });
//                   },
//                   onDecreaseQuantity: () {
//                     ref
//                         .read(singleProductViewModelProvider.notifier)
//                         .updateSelectedQuantity(
//                             productState.selectedQuantity - 1);
//                   },
//                   onIncreaseQuantity: () {
//                     ref
//                         .read(singleProductViewModelProvider.notifier)
//                         .updateSelectedQuantity(
//                             productState.selectedQuantity + 1);
//                   },
//                   onCartPressed: () {
//                     ref.read(cartViewModelProvider.notifier).addCart(
//                         productState.singleProduct!.id!,
//                         productState.selectedQuantity);
//                   },
//                   reviews: reviews,
//                   reviewController: reviewController,
//                   addReview: addReview,
//                   reviewonPressed: () {
//                     if (reviewController.text.isNotEmpty) {
//                       addReview(reviewController.text);
//                     }
//                   },
//                 ),
//               if (productState.isLoading)
//                 const Center(child: CircularProgressIndicator()),
//               if (productState.error != null)
//                 Center(child: Text(productState.error!)),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:final_assignment/features/cart/presentation/viewmodel/cart_view_model.dart';
// import 'package:final_assignment/features/ratingandreview/presentation/view_model/rating_review_view_model.dart';
// import 'package:final_assignment/features/single_product/presentation/view_model/single_product_view_model.dart';
// import 'package:final_assignment/features/single_product/presentation/widgets/product_details.dart';
// import 'package:final_assignment/features/wishlist/presentation/view_model/wishlist_view_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// class ProductViewPage extends ConsumerStatefulWidget {
//   final String productId;
//
//   const ProductViewPage({Key? key, required this.productId}) : super(key: key);
//
//   @override
//   _ProductViewPageState createState() => _ProductViewPageState();
// }
//
// class _ProductViewPageState extends ConsumerState<ProductViewPage> {
//   bool isDescriptionExpanded = false;
//   bool isReviewsExpanded = false;
//   List<String> reviews = ['Great product!', 'Love the color options.'];
//   TextEditingController reviewController = TextEditingController();
//   double rating = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchProductDetails();
//   }
//
//   void _fetchProductDetails() {
//     Future.microtask(() {
//       ref
//           .read(singleProductViewModelProvider.notifier)
//           .getSingleProduct(widget.productId);
//     });
//   }
//
//   void addReview(String review) {
//     setState(() {
//       reviews.add(review);
//       reviewController.clear();
//     });
//   }
//
//   void reviewonPressed(double rating, String review) {
//     ref
//         .read(ratingReviewViewModelProvider.notifier)
//         .addRatingReview(widget.productId, rating, review);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final productState = ref.watch(singleProductViewModelProvider);
//
//     return Scaffold(
//       backgroundColor: Colors.grey[300],
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               // Header
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     IconButton(
//                       icon: const Icon(Icons.arrow_back),
//                       onPressed: () => Navigator.of(context).pop(),
//                     ),
//                     IconButton(
//                         onPressed: () {
//                           ref
//                               .read(wishlistViewModelProvider.notifier)
//                               .addWishlist(productState.singleProduct!.id!);
//                         },
//                         icon: Icon(Icons.favorite_border)),
//                   ],
//                 ),
//               ),
//
//               // Product Details
//               if (productState.singleProduct != null)
//                 ProductDetails(
//                   product: productState.singleProduct!,
//                   selectedQuantity: productState.selectedQuantity,
//                   isDescriptionExpanded: isDescriptionExpanded,
//                   onDescriptionToggle: () {
//                     setState(() {
//                       isDescriptionExpanded = !isDescriptionExpanded;
//                     });
//                   },
//                   isReviewsExpanded: isReviewsExpanded,
//                   onReviewsToggle: () {
//                     setState(() {
//                       isReviewsExpanded = !isReviewsExpanded;
//                     });
//                   },
//                   onDecreaseQuantity: () {
//                     ref
//                         .read(singleProductViewModelProvider.notifier)
//                         .updateSelectedQuantity(
//                             productState.selectedQuantity - 1);
//                   },
//                   onIncreaseQuantity: () {
//                     ref
//                         .read(singleProductViewModelProvider.notifier)
//                         .updateSelectedQuantity(
//                             productState.selectedQuantity + 1);
//                   },
//                   onCartPressed: () {
//                     ref.read(cartViewModelProvider.notifier).addCart(
//                         productState.singleProduct!.id!,
//                         productState.selectedQuantity);
//                   },
//                   reviews: reviews,
//                   reviewController: reviewController,
//                   addReview: addReview,
//                   reviewonPressed: reviewonPressed,
//                 ),
//               if (productState.isLoading)
//                 const Center(child: CircularProgressIndicator()),
//               if (productState.error != null)
//                 Center(child: Text(productState.error!)),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:final_assignment/features/cart/presentation/viewmodel/cart_view_model.dart';
// import 'package:final_assignment/features/ratingandreview/presentation/view_model/rating_review_view_model.dart';
// import 'package:final_assignment/features/single_product/presentation/view_model/single_product_view_model.dart';
// import 'package:final_assignment/features/single_product/presentation/widgets/product_details.dart';
// import 'package:final_assignment/features/wishlist/presentation/view_model/wishlist_view_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// class ProductViewPage extends ConsumerStatefulWidget {
//   final String productId;
//
//   const ProductViewPage({Key? key, required this.productId}) : super(key: key);
//
//   @override
//   _ProductViewPageState createState() => _ProductViewPageState();
// }
//
// class _ProductViewPageState extends ConsumerState<ProductViewPage> {
//   bool isDescriptionExpanded = false;
//   bool isReviewsExpanded = false;
//   List<String> reviews = ['Great product!', 'Love the color options.'];
//   TextEditingController reviewController = TextEditingController();
//   double rating = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchProductDetails();
//   }
//
//   void _fetchProductDetails() {
//     Future.microtask(() {
//       ref
//           .read(singleProductViewModelProvider.notifier)
//           .getSingleProduct(widget.productId);
//     });
//   }
//
//   void addReview(String review) {
//     setState(() {
//       reviews.add(review);
//       reviewController.clear();
//     });
//   }
//
//   void reviewonPressed(double rating, String review) {
//     ref
//         .read(ratingReviewViewModelProvider.notifier)
//         .addRatingReview(widget.productId, rating, review);
//   }
//
//   void updateReview(double rating, String review) {
//     ref
//         .read(ratingReviewViewModelProvider.notifier)
//         .updateRatingReview(widget.productId, rating, review);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final productState = ref.watch(singleProductViewModelProvider);
//
//     return Scaffold(
//       backgroundColor: Colors.grey[300],
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               // Header
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     IconButton(
//                       icon: const Icon(Icons.arrow_back),
//                       onPressed: () => Navigator.of(context).pop(),
//                     ),
//                     IconButton(
//                         onPressed: () {
//                           ref
//                               .read(wishlistViewModelProvider.notifier)
//                               .addWishlist(productState.singleProduct!.id!);
//                         },
//                         icon: Icon(Icons.favorite_border)),
//                   ],
//                 ),
//               ),
//
//               // Product Details
//               if (productState.singleProduct != null)
//                 ProductDetails(
//                   product: productState.singleProduct!,
//                   selectedQuantity: productState.selectedQuantity,
//                   isDescriptionExpanded: isDescriptionExpanded,
//                   onDescriptionToggle: () {
//                     setState(() {
//                       isDescriptionExpanded = !isDescriptionExpanded;
//                     });
//                   },
//                   isReviewsExpanded: isReviewsExpanded,
//                   onReviewsToggle: () {
//                     setState(() {
//                       isReviewsExpanded = !isReviewsExpanded;
//                     });
//                   },
//                   onDecreaseQuantity: () {
//                     ref
//                         .read(singleProductViewModelProvider.notifier)
//                         .updateSelectedQuantity(
//                             productState.selectedQuantity - 1);
//                   },
//                   onIncreaseQuantity: () {
//                     ref
//                         .read(singleProductViewModelProvider.notifier)
//                         .updateSelectedQuantity(
//                             productState.selectedQuantity + 1);
//                   },
//                   onCartPressed: () {
//                     ref.read(cartViewModelProvider.notifier).addCart(
//                         productState.singleProduct!.id!,
//                         productState.selectedQuantity);
//                   },
//                   reviews: reviews,
//                   reviewController: reviewController,
//                   addReview: addReview,
//                   reviewonPressed: reviewonPressed,
//                   rating: rating,
//                   updateReview: updateReview,
//                 ),
//               if (productState.isLoading)
//                 const Center(child: CircularProgressIndicator()),
//               if (productState.error != null)
//                 Center(child: Text(productState.error!)),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:final_assignment/features/cart/presentation/viewmodel/cart_view_model.dart';
import 'package:final_assignment/features/ratingandreview/presentation/view_model/rating_review_view_model.dart';
import 'package:final_assignment/features/single_product/presentation/view_model/single_product_view_model.dart';
import 'package:final_assignment/features/single_product/presentation/widgets/product_details.dart';
import 'package:final_assignment/features/wishlist/presentation/view_model/wishlist_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductViewPage extends ConsumerStatefulWidget {
  final String productId;

  const ProductViewPage({Key? key, required this.productId}) : super(key: key);

  @override
  _ProductViewPageState createState() => _ProductViewPageState();
}

class _ProductViewPageState extends ConsumerState<ProductViewPage> {
  bool isDescriptionExpanded = false;
  bool isReviewsExpanded = false;
  TextEditingController reviewController = TextEditingController();
  double rating = 0;

  @override
  void initState() {
    super.initState();
    _fetchProductDetails();
    _fetchProductReviews();
  }

  void _fetchProductDetails() {
    Future.microtask(() {
      ref
          .read(singleProductViewModelProvider.notifier)
          .getSingleProduct(widget.productId);
    });
  }

  void _fetchProductReviews() {
    Future.microtask(() {
      ref
          .read(ratingReviewViewModelProvider.notifier)
          .getReviewsByProduct(widget.productId);
    });
  }

  void addReview(String review) {
    setState(() {
      reviewController.clear();
    });
  }

  void reviewonPressed(double rating, String review) {
    ref
        .read(ratingReviewViewModelProvider.notifier)
        .addRatingReview(widget.productId, rating, review);
    _fetchProductReviews(); // Refresh reviews after adding
  }

  void updateReview(double rating, String review) {
    ref
        .read(ratingReviewViewModelProvider.notifier)
        .updateRatingReview(widget.productId, rating, review);
    _fetchProductReviews(); // Refresh reviews after updating
  }

  @override
  Widget build(BuildContext context) {
    final productState = ref.watch(singleProductViewModelProvider);
    final reviewState = ref.watch(ratingReviewViewModelProvider);

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    IconButton(
                        onPressed: () {
                          ref
                              .read(wishlistViewModelProvider.notifier)
                              .addWishlist(productState.singleProduct!.id!);
                        },
                        icon: Icon(Icons.favorite_border)),
                  ],
                ),
              ),

              // Product Details
              if (productState.singleProduct != null)
                ProductDetails(
                  product: productState.singleProduct!,
                  selectedQuantity: productState.selectedQuantity,
                  isDescriptionExpanded: isDescriptionExpanded,
                  onDescriptionToggle: () {
                    setState(() {
                      isDescriptionExpanded = !isDescriptionExpanded;
                    });
                  },
                  isReviewsExpanded: isReviewsExpanded,
                  onReviewsToggle: () {
                    setState(() {
                      isReviewsExpanded = !isReviewsExpanded;
                    });
                  },
                  onDecreaseQuantity: () {
                    ref
                        .read(singleProductViewModelProvider.notifier)
                        .updateSelectedQuantity(
                            productState.selectedQuantity - 1);
                  },
                  onIncreaseQuantity: () {
                    ref
                        .read(singleProductViewModelProvider.notifier)
                        .updateSelectedQuantity(
                            productState.selectedQuantity + 1);
                  },
                  onCartPressed: () {
                    ref.read(cartViewModelProvider.notifier).addCart(
                        productState.singleProduct!.id!,
                        productState.selectedQuantity);
                  },
                  reviews: reviewState.reviews.map((e) => e.review).toList(),
                  reviewController: reviewController,
                  addReview: addReview,
                  reviewonPressed: reviewonPressed,
                  rating: rating,
                  updateReview: updateReview,
                ),
              if (productState.isLoading || reviewState.isLoading)
                const Center(child: CircularProgressIndicator()),
              if (productState.error != null)
                Center(child: Text(productState.error!)),
              if (reviewState.error != null)
                Center(child: Text(reviewState.error!)),
            ],
          ),
        ),
      ),
    );
  }
}
