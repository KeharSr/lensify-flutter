class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 8000);
  static const Duration receiveTimeout = Duration(seconds: 8000);
  static const String baseUrl = 'http://192.168.1.133:5000/api/';

  // ===========Auth Routes===========
  static const String loginUser = 'user/login';
  static const String createUser = 'user/create';
  static const String currentUser = 'user/current';
  static const String getToken = "user/token";
  static const String profileImage = 'user/profile_picture';
  static const String imageUrlprofile =
      "http://192.168.1.133:5000/profile_pictures/";
  static const String updateUser = 'user/update';
  static const String sentOtp = 'user/forgot_password';
  static const String verifyOtp = 'user/verify_otp';

  // ===========Google Login Routes===========
  static const String googleLogin = 'user/google';
  static const String getUserByGoogle = 'user/getGoogleUser';

  // ===========Product Routes===========
  static const String getProductsByCategory =
      'product/get_products_by_category';
  static const int limit = 2;
  static const getSingleProduct = 'product/get_single_product/';
  static const String imageUrl = 'http://192.168.1.133:5000/products/';

  // ===========Cart Routes===========
  static const String addToCart = 'cart/add_to_cart';
  static const String getCart = 'cart/get_cart';
  static const String updateCart = 'cart/update_cart';
  static const String deleteCart = 'cart/remove_cart_item/';

// ===========Wishlist Routes===========
  static const String addFavourite = 'favourite/add_favourite';
  static const String getFavourite = 'favourite/get_favourite';
  static const String deleteFavourite = 'favourite/remove_favourite/';

  // ===========Rating and Review Routes===========
  static const String addRatingReview = 'review/post_reviews';
  static const String getAverageRating = 'review/get_average_rating/';
  static const String updateRatingReview = 'review/update_reviews/';
  static const String getReviews = 'review/get_reviews/';
  static const String getReviewsByUserAndProduct =
      'review/get_reviews_by_user_and_product/';

  // ===========Place Order Routes===========
  static const String placeOrder = 'order/place_order';
  static const String getOrders = 'order/get_orders_by_user';

  // ===========Payment Routes===========
  static const String initlizePayment = 'khalti/initialize-khalti';
  static const String verifyPayment = 'khalti/complete-khalti-payment';
}
