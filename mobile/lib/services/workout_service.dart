// lib/services/workout_service.dart
import 'package:dio/dio.dart';
import 'server.dart';
import 'dart:convert';

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
  /*Future<Map<String, dynamic>> enviarAnalisisPostura(
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
  }*/

  /*
  Future<Map<String, dynamic>> enviarAnalisisPostura(
    AnalisisPostura analisis,
  ) async {
    try {
      // Preparar datos según lo que espera el backend
      final Map<String, dynamic> requestData = {
        'ejercicio': int.tryParse(analisis.ejercicio) ?? 1,
        'modelo_ia': 1, // ID del modelo por defecto (ajustar si es necesario)
        'puntos_corporales_detectados': analisis.puntosCorporales,
        'precision_deteccion': analisis.precision,
        'puntuacion_tecnica': analisis.puntuacion,
        // Los campos opcionales solo si existen
        if (analisis.repeticiones > 0) 'repeticiones': analisis.repeticiones,
      };

      print('=== ENVIANDO AL BACKEND ===');
      print('Endpoint: /detecciones-postura/');
      print('Datos: $requestData');

      final response = await _servidor.dio.post(
        '/detecciones-postura/',
        data: requestData,
      );

      print('Respuesta del backend:');
      print('Status: ${response.statusCode}');
      print('Data: ${response.data}');

      if (response.statusCode == 201) {
        return {
          'success': true,
          'data': response.data,
          'message': 'Análisis enviado correctamente',
        };
      } else {
        return {
          'success': false,
          'error': 'Error del servidor: ${response.statusCode}',
          'response_data': response.data,
        };
      }
    } on DioException catch (e) {
      print('=== ERROR DIO ===');
      print('Mensaje: ${e.message}');
      print('Error: ${e.error}');

      if (e.response != null) {
        print('Status: ${e.response!.statusCode}');
        print('Headers: ${e.response!.headers}');
        print('Data: ${e.response!.data}');
      }

      return {
        'success': false,
        'error': 'Error de conexión: ${e.message}',
        'response_data': e.response?.data,
      };
    } catch (e) {
      print('=== ERROR GENERAL ===');
      print('Error: $e');

      return {'success': false, 'error': 'Error inesperado: $e'};
    }
  }
*/

  Future<Map<String, dynamic>> enviarAnalisisPostura(
    AnalisisPostura analisis,
  ) async {
    try {
      // PRIMERO: Probar encontrar formato correcto
      print('=== BUSCANDO FORMATO CORRECTO ===');
      final pruebaFormato = await encontrarFormatoCorrecto(
        int.tryParse(analisis.ejercicio) ?? 1,
      );

      if (pruebaFormato['success'] == true) {
        print('✅ Formato encontrado: ${pruebaFormato['working_format']}');

        // Usar el formato que funcionó
        final requestData =
            pruebaFormato['format_data'] as Map<String, dynamic>;

        print('=== ENVIANDO CON FORMATO CORRECTO ===');
        final response = await _servidor.dio.post(
          '/detecciones-postura/',
          data: requestData,
        );

        if (response.statusCode == 201) {
          return {
            'success': true,
            'data': response.data,
            'message': 'Análisis enviado correctamente',
          };
        }
      }

      // Si no encontramos formato, intentar uno básico
      print('=== INTENTANDO FORMATO BÁSICO ===');
      final Map<String, dynamic> requestData = {
        'ejercicio': int.tryParse(analisis.ejercicio) ?? 1,
        'precision_deteccion': analisis.precision,
        'puntuacion_tecnica': analisis.puntuacion,
      };

      // Solo agregar modelo_ia si es necesario
      if (analisis.puntosCorporales.isNotEmpty) {
        requestData['modelo_ia'] = 1;
        requestData['puntos_corporales_detectados'] = analisis.puntosCorporales;
      }

      print('Datos finales: $requestData');

      final response = await _servidor.dio.post(
        '/detecciones-postura/',
        data: requestData,
        options: Options(
          validateStatus: (status) => true,
        ), // Aceptar todos status
      );

      print('Respuesta: ${response.statusCode}');
      print('Data: ${response.data}');

      if (response.statusCode == 201) {
        return {
          'success': true,
          'data': response.data,
          'message': 'Análisis enviado correctamente',
        };
      } else {
        // Mostrar errores detallados
        String errorMsg = 'Error ${response.statusCode}';
        if (response.data is Map) {
          final errors = response.data as Map;
          errorMsg += ' - Errores: ';
          errors.forEach((key, value) {
            errorMsg += '$key: $value; ';
          });
        } else if (response.data is String) {
          errorMsg += ' - ${response.data}';
        }

        return {
          'success': false,
          'error': errorMsg,
          'response_data': response.data,
        };
      }
    } on DioException catch (e) {
      print('=== ERROR DIO ===');
      print('Type: ${e.type}');
      print('Message: ${e.message}');

      if (e.response != null) {
        print('Status: ${e.response!.statusCode}');
        print('Response Data: ${e.response!.data}');
      }

      return {
        'success': false,
        'error': 'Error de conexión: ${e.message}',
        'response_data': e.response?.data,
      };
    }
  }

  // Método para probar múltiples formatos
  Future<Map<String, dynamic>> encontrarFormatoCorrecto(int ejercicioId) async {
    final formatos = [
      {
        'name': 'Formato MINIMO - sin puntos',
        'data': {
          'ejercicio': ejercicioId,
          'modelo_ia': 1,
          'precision_deteccion': 0.85,
          'puntuacion_tecnica': 75,
        },
      },
      {
        'name': 'Formato puntos vacío',
        'data': {
          'ejercicio': ejercicioId,
          'modelo_ia': 1,
          'puntos_corporales_detectados': {},
          'precision_deteccion': 0.85,
          'puntuacion_tecnica': 75,
        },
      },
      {
        'name': 'Formato puntos null',
        'data': {
          'ejercicio': ejercicioId,
          'modelo_ia': 1,
          'puntos_corporales_detectados': null,
          'precision_deteccion': 0.85,
          'puntuacion_tecnica': 75,
        },
      },
      {
        'name': 'Formato string simple',
        'data': {
          'ejercicio': ejercicioId,
          'modelo_ia': 1,
          'puntos_corporales_detectados': '{"keypoints": [0.1, 0.2]}',
          'precision_deteccion': 0.85,
          'puntuacion_tecnica': 75,
        },
      },
    ];

    for (final formato in formatos) {
      print('\n=== Probando: ${formato['name']} ===');
      print('Datos: ${formato['data']}');

      try {
        final response = await _servidor.dio.post(
          '/detecciones-postura/',
          data: formato['data'],
          options: Options(
            validateStatus: (status) {
              // Aceptar todos los status para debugging
              return true;
            },
          ),
        );

        print('Status: ${response.statusCode}');
        print('Respuesta: ${response.data}');

        if (response.statusCode == 201) {
          print('✅ ✅ ✅ FORMATO FUNCIONA: ${formato['name']}');
          return {
            'success': true,
            'working_format': formato['name'],
            'format_data': formato['data'],
            'response': response.data,
          };
        } else if (response.statusCode == 400) {
          print('❌ Error 400 - Detalles:');
          if (response.data is Map) {
            final errors = response.data as Map;
            errors.forEach((key, value) {
              print('  $key: $value');
            });
          } else {
            print('  ${response.data}');
          }
        }
      } catch (e) {
        print('Excepción: $e');
      }

      await Future.delayed(const Duration(seconds: 2));
    }

    return {'success': false, 'error': 'Ningún formato funcionó'};
  }

  // Método para formatear puntos al formato que espera Django
  Map<String, dynamic> _formatearPuntosParaBackend(
    Map<String, dynamic> puntosOriginales,
  ) {
    try {
      // Opción 1: Formato simple - solo keypoints
      final List<double> keypoints = [];

      if (puntosOriginales.containsKey('landmarks')) {
        final landmarks = puntosOriginales['landmarks'] as Map<String, dynamic>;

        landmarks.forEach((_, landmarkData) {
          if (landmarkData is Map) {
            keypoints.add(landmarkData['x']?.toDouble() ?? 0.0);
            keypoints.add(landmarkData['y']?.toDouble() ?? 0.0);
          }
        });
      }

      // Opción 2: Formato estructurado que Django pueda parsear
      return {
        'version': '1.0',
        'timestamp': DateTime.now().toIso8601String(),
        'keypoints': keypoints,
        'landmarks_count': keypoints.length ~/ 2,
        'metadata': {
          'source': 'flutter_mlkit',
          'detection_time': DateTime.now().millisecondsSinceEpoch,
        },
      };
    } catch (e) {
      print('Error formateando puntos: $e');
      return {
        'error': 'No se pudieron formatear los puntos',
        'raw_data': puntosOriginales,
      };
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
