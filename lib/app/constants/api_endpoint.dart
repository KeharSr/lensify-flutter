class ApiEndpoints{
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  static const String baseUrl = 'https://192.168.56.1:3000/api/v1/';

}