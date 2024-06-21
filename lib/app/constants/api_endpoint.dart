class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 8000);
  static const Duration receiveTimeout = Duration(seconds: 8000);
  // static const String baseUrl = 'http://192.168.1.133:5000/api/';
    static const String baseUrl = "http://10.0.2.2:5000/api/";

// ===========Auth Routes===========
  static const String loginUser = 'user/login';
  static const String createUser = 'user/create';
  static const String currentUser = 'user/existingUser';
}
