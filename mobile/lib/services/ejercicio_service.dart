import 'package:dio/dio.dart';
import '../data/remote/models/ejercicio_model.dart';
import 'server.dart';

class EjercicioService {
  final Servidor _servidor = Servidor();

  Future<List<EjercicioModel>> getEjercicios() async {
    try {
      final response = await _servidor.dio.get('/ejercicios/');

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['results'] != null) {
          final List<dynamic> results = data['results'];
          return results.map((json) => EjercicioModel.fromJson(json)).toList();
        }
        return [];
      }
      return [];
    } on DioException catch (e) {
      print('Error obteniendo ejercicios: ${e.message}');
      return [];
    }
  }

  Future<List<EjercicioModel>> getEjerciciosPorTipo(String tipo) async {
    try {
      final response = await _servidor.dio.get(
        '/ejercicios/por_tipo/',
        queryParameters: {'tipo': tipo},
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['results'] != null) {
          final List<dynamic> results = data['results'];
          return results.map((json) => EjercicioModel.fromJson(json)).toList();
        }
        return [];
      }
      return [];
    } on DioException catch (e) {
      print('Error obteniendo ejercicios por tipo: ${e.message}');
      return [];
    }
  }

  Future<List<EjercicioModel>> getEjerciciosPorGrupoMuscular(
    String grupo,
  ) async {
    try {
      final response = await _servidor.dio.get(
        '/ejercicios/por_grupo_muscular/',
        queryParameters: {'grupo': grupo},
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['results'] != null) {
          final List<dynamic> results = data['results'];
          return results.map((json) => EjercicioModel.fromJson(json)).toList();
        }
        return [];
      }
      return [];
    } on DioException catch (e) {
      print('Error obteniendo ejercicios por grupo: ${e.message}');
      return [];
    }
  }

  Future<EjercicioModel?> getEjercicioById(int id) async {
    try {
      final response = await _servidor.dio.get('/ejercicios/$id/');

      if (response.statusCode == 200) {
        return EjercicioModel.fromJson(response.data);
      }
      return null;
    } on DioException catch (e) {
      print('Error obteniendo ejercicio: ${e.message}');
      return null;
    }
  }
}
