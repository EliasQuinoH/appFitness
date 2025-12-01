// lib/services/workout_service.dart
import 'package:dio/dio.dart';
import 'server.dart';

// Modelo para análisis de postura (fuera de la clase)
class AnalisisPostura {
  final Map<String, dynamic> puntosCorporales;
  final double precision;
  final int puntuacion;
  final String ejercicio;
  final int repeticiones;

  AnalisisPostura({
    required this.puntosCorporales,
    required this.precision,
    required this.puntuacion,
    required this.ejercicio,
    this.repeticiones = 0,
  });

  Map<String, dynamic> toJson() {
    return {
      'puntos_corporales': puntosCorporales,
      'precision': precision,
      'puntuacion': puntuacion,
      'ejercicio': ejercicio,
      'repeticiones': repeticiones,
    };
  }
}

class WorkoutService {
  final Servidor _servidor = Servidor();

  // Enviar análisis de postura al backend
  Future<Map<String, dynamic>> enviarAnalisisPostura(
    AnalisisPostura analisis,
  ) async {
    try {
      final response = await _servidor.dio.post(
        '/detecciones-postura/',
        data: analisis.toJson(),
      );

      if (response.statusCode == 201) {
        return {
          'success': true,
          'data': response.data,
          'message': 'Análisis enviado correctamente',
        };
      }

      return {
        'success': false,
        'error': 'Error del servidor: ${response.statusCode}',
      };
    } on DioException catch (e) {
      return {'success': false, 'error': 'Error de conexión: ${e.message}'};
    }
  }

  // Obtener modelos de IA disponibles para un ejercicio
  Future<List<Map<String, dynamic>>> getModelosParaEjercicio(
    String tipoEjercicio,
  ) async {
    try {
      final response = await _servidor.dio.get(
        '/modelos-ia/',
        queryParameters: {'tipo_ejercicio': tipoEjercicio},
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['results'] != null) {
          final List<dynamic> results = data['results'];
          return results
              .map((json) => Map<String, dynamic>.from(json))
              .toList();
        }
      }
      return [];
    } on DioException catch (e) {
      print('Error obteniendo modelos IA: ${e.message}');
      return [];
    }
  }

  // Obtener retroalimentación de una detección
  Future<List<Map<String, dynamic>>> getRetroalimentacion(
    int deteccionId,
  ) async {
    try {
      final response = await _servidor.dio.get(
        '/retroalimentacion/',
        queryParameters: {'deteccion': deteccionId},
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['results'] != null) {
          final List<dynamic> results = data['results'];
          return results
              .map((json) => Map<String, dynamic>.from(json))
              .toList();
        }
      }
      return [];
    } on DioException catch (e) {
      print('Error obteniendo retroalimentación: ${e.message}');
      return [];
    }
  }

  // Marcar corrección como resuelta
  Future<bool> marcarCorreccionResuelta(int retroalimentacionId) async {
    try {
      final response = await _servidor.dio.post(
        '/retroalimentacion/$retroalimentacionId/marcar_corregido/',
      );

      return response.statusCode == 200;
    } on DioException catch (e) {
      print('Error marcando corrección: ${e.message}');
      return false;
    }
  }
}
