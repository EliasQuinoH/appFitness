// lib/services/user_service.dart
import 'package:dio/dio.dart';
import '../data/remote/models/user_model.dart';
import 'server.dart';

class UserService {
  final Servidor _servidor = Servidor();

  Future<UserModel?> getPerfilUsuario() async {
    try {
      final response = await _servidor.dio.get('/usuarios/perfil/');

      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data); // Directamente response.data
      }
      return null;
    } on DioException catch (e) {
      print('Error obteniendo perfil: ${e.message}');
      return null;
    }
  }

  Future<UserModel?> actualizarPerfil(Map<String, dynamic> datos) async {
    try {
      final response = await _servidor.dio.put(
        '/usuarios/actualizar_perfil/',
        data: datos,
      );

      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      }
      return null;
    } on DioException catch (e) {
      print('Error actualizando perfil: ${e.message}');
      return null;
    }
  }

  Future<Map<String, dynamic>> getEstadisticas() async {
    try {
      final response = await _servidor.dio.get('/usuarios/estadisticas/');

      if (response.statusCode == 200) {
        return response.data; // Directamente response.data
      }
      return {};
    } on DioException catch (e) {
      print('Error obteniendo estadísticas: ${e.message}');
      return {};
    }
  }
}
