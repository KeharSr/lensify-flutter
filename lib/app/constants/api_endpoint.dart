class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 8000);
  static const Duration receiveTimeout = Duration(seconds: 8000);

  static const String baseUrl = 'http://192.168.1.133:5000/api/';

  // static const String baseUrl = "http://172.26.1.49:5000/api/";

// ===========Auth Routes===========
  static const String loginUser = 'user/login';
  static const String createUser = 'user/create';
  static const String currentUser = 'user/current';
  static const String getToken = "user/token";

// ============Product Routes ==========
  static const String getAllProducts = 'products/get_all_products';
  static const String updateProduct = 'products/update_Product';

  static const String paginatonProducts = 'product/pagination';
  static const int limitPage = 2;

  static const String imageUrl = 'http://192.168.1.133:5000/products/';
// static const String imageUrl = 'http://172.26.1.49:5000/products/';
}
