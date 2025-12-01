import 'package:dio/dio.dart';

class Servidor {
  static final Servidor _instance = Servidor._internal();
  factory Servidor() => _instance;
  Servidor._internal() {
    // Configurar interceptores para headers por defecto
    dio.options.baseUrl = baseUrl;
    dio.options.connectTimeout = const Duration(seconds: 30);
    dio.options.receiveTimeout = const Duration(seconds: 30);
    dio.options.headers = {'Content-Type': 'application/json'};
  }

  final String baseUrl =
      'https://abc-fitness-gamificado-backend.duckdns.org/api';
  final Dio dio = Dio();

  // Método para actualizar el token en las peticiones
  void setAuthToken(String token) {
    dio.options.headers['Authorization'] = 'Bearer $token';
  }

  // Método para remover el token (logout)
  void removeAuthToken() {
    dio.options.headers.remove('Authorization');
  }
}
