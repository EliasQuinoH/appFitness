import 'package:dio/dio.dart';
import 'server.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final Servidor _servidor = Servidor();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // Keys para almacenamiento seguro
  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';
  static const _userDataKey = 'user_data';

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await _servidor.dio.post(
        '/auth/login/',
        data: {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        final data = response.data;

        // Guardar tokens
        await _storage.write(key: _accessTokenKey, value: data['access']);
        await _storage.write(key: _refreshTokenKey, value: data['refresh']);
        await _storage.write(key: _userDataKey, value: data['user'].toString());

        // Configurar token en las peticiones futuras
        _servidor.setAuthToken(data['access']);

        return {
          'success': true,
          'user': data['user'],
          'tokens': {'access': data['access'], 'refresh': data['refresh']},
        };
      }

      return {'success': false, 'error': 'Credenciales incorrectas'};
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        return {'success': false, 'error': 'Email o contraseña incorrectos'};
      }
      return {'success': false, 'error': 'Error de conexión: ${e.message}'};
    } catch (e) {
      return {'success': false, 'error': 'Error inesperado: $e'};
    }
  }

  Future<Map<String, dynamic>> register(Map<String, dynamic> userData) async {
    try {
      final response = await _servidor.dio.post(
        '/auth/register/',
        data: userData,
      );

      if (response.statusCode == 201) {
        final data = response.data;

        // Guardar tokens
        await _storage.write(key: _accessTokenKey, value: data['access']);
        await _storage.write(key: _refreshTokenKey, value: data['refresh']);
        await _storage.write(key: _userDataKey, value: data['user'].toString());

        // Configurar token en las peticiones futuras
        _servidor.setAuthToken(data['access']);

        return {
          'success': true,
          'user': data['user'],
          'tokens': {'access': data['access'], 'refresh': data['refresh']},
        };
      }

      return {'success': false, 'error': 'Error en el registro'};
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        final errors = e.response?.data;
        return {'success': false, 'error': 'Datos inválidos: $errors'};
      }
      return {'success': false, 'error': 'Error de conexión: ${e.message}'};
    } catch (e) {
      return {'success': false, 'error': 'Error inesperado: $e'};
    }
  }

  Future<void> logout() async {
    try {
      // Opcional: llamar al endpoint de logout del backend
      await _servidor.dio.post('/auth/logout/');
    } catch (e) {
      // Ignorar errores en logout
    } finally {
      // Limpiar tokens locales
      await _storage.delete(key: _accessTokenKey);
      await _storage.delete(key: _refreshTokenKey);
      await _storage.delete(key: _userDataKey);
      _servidor.removeAuthToken();
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: _accessTokenKey);
    return token != null;
  }

  Future<String?> getAccessToken() async {
    return await _storage.read(key: _accessTokenKey);
  }
}
