// lib/services/ia_service.dart
import 'package:dio/dio.dart';
import 'server.dart';

// Modelo para modelo de IA (fuera de la clase)
class ModeloIAModel {
  final int id;
  final String nombreModelo;
  final String tipoEjercicio;
  final String version;
  final Map<String, dynamic> puntosReferencia;
  final Map<String, dynamic> angulosIdeales;
  final double umbralPrecision;
  final bool estaActivo;

  ModeloIAModel({
    required this.id,
    required this.nombreModelo,
    required this.tipoEjercicio,
    required this.version,
    required this.puntosReferencia,
    required this.angulosIdeales,
    required this.umbralPrecision,
    required this.estaActivo,
  });

  factory ModeloIAModel.fromJson(Map<String, dynamic> json) {
    return ModeloIAModel(
      id: json['id'],
      nombreModelo: json['nombre_modelo'],
      tipoEjercicio: json['tipo_ejercicio'],
      version: json['version'],
      puntosReferencia: Map<String, dynamic>.from(json['puntos_referencia']),
      angulosIdeales: Map<String, dynamic>.from(json['angulos_ideales']),
      umbralPrecision: json['umbral_precision']?.toDouble() ?? 0.8,
      estaActivo: json['esta_activo'],
    );
  }
}

// Modelo para request de detección de postura (fuera de la clase)
class DeteccionPosturaRequest {
  final int ejercicio;
  final int modeloIa;
  final Map<String, dynamic> puntosCorporalesDetectados;
  final double precisionDeteccion;
  final int puntuacionTecnica;
  final String? imagenAnalizadaUrl;
  final String? videoAnalizadoUrl;
  final double duracionAnalisisSegundos;
  final Map<String, dynamic>? metadataAnalisis;

  DeteccionPosturaRequest({
    required this.ejercicio,
    required this.modeloIa,
    required this.puntosCorporalesDetectados,
    required this.precisionDeteccion,
    required this.puntuacionTecnica,
    this.imagenAnalizadaUrl,
    this.videoAnalizadoUrl,
    required this.duracionAnalisisSegundos,
    this.metadataAnalisis,
  });

  Map<String, dynamic> toJson() {
    return {
      'ejercicio': ejercicio,
      'modelo_ia': modeloIa,
      'puntos_corporales_detectados': puntosCorporalesDetectados,
      'precision_deteccion': precisionDeteccion,
      'puntuacion_tecnica': puntuacionTecnica,
      'imagen_analizada_url': imagenAnalizadaUrl,
      'video_analizado_url': videoAnalizadoUrl,
      'duracion_analisis_segundos': duracionAnalisisSegundos,
      'metadata_analisis': metadataAnalisis,
    };
  }
}

// Modelo para respuesta de detección (fuera de la clase)
class DeteccionPosturaResponse {
  final int id;
  final DateTime fechaDeteccion;
  final bool esConfiable;
  final String nivelCalificacion;
  final int recompensaPuntos;

  DeteccionPosturaResponse({
    required this.id,
    required this.fechaDeteccion,
    required this.esConfiable,
    required this.nivelCalificacion,
    required this.recompensaPuntos,
  });

  factory DeteccionPosturaResponse.fromJson(Map<String, dynamic> json) {
    return DeteccionPosturaResponse(
      id: json['id'],
      fechaDeteccion: DateTime.parse(json['fecha_deteccion']),
      esConfiable: json['es_confiable'],
      nivelCalificacion: json['nivel_calificacion'],
      recompensaPuntos: json['recompensa_puntos'],
    );
  }
}

class IAService {
  final Servidor _servidor = Servidor();

  Future<List<ModeloIAModel>> getModelosIA() async {
    try {
      final response = await _servidor.dio.get('/modelos-ia/');

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['results'] != null) {
          final List<dynamic> results = data['results'];
          return results.map((json) => ModeloIAModel.fromJson(json)).toList();
        }
        return [];
      }
      return [];
    } on DioException catch (e) {
      print('Error obteniendo modelos IA: ${e.message}');
      return [];
    }
  }

  Future<List<ModeloIAModel>> getModelosPorEjercicio(
    String tipoEjercicio,
  ) async {
    try {
      final response = await _servidor.dio.get(
        '/modelos-ia/por_ejercicio/',
        queryParameters: {'tipo_ejercicio': tipoEjercicio},
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['results'] != null) {
          final List<dynamic> results = data['results'];
          return results.map((json) => ModeloIAModel.fromJson(json)).toList();
        }
        return [];
      }
      return [];
    } on DioException catch (e) {
      print('Error obteniendo modelos por ejercicio: ${e.message}');
      return [];
    }
  }

  Future<DeteccionPosturaResponse?> enviarDeteccion(
    DeteccionPosturaRequest deteccion,
  ) async {
    try {
      final response = await _servidor.dio.post(
        '/detecciones-postura/',
        data: deteccion.toJson(),
      );

      if (response.statusCode == 201) {
        return DeteccionPosturaResponse.fromJson(response.data);
      }
      return null;
    } on DioException catch (e) {
      print('Error enviando detección: ${e.message}');
      if (e.response != null) {
        print('Response data: ${e.response!.data}');
        print('Response status: ${e.response!.statusCode}');
      }
      return null;
    }
  }

  Future<List<DeteccionPosturaResponse>> getMisDetecciones() async {
    try {
      final response = await _servidor.dio.get('/detecciones-postura/');

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['results'] != null) {
          final List<dynamic> results = data['results'];
          return results
              .map((json) => DeteccionPosturaResponse.fromJson(json))
              .toList();
        }
        return [];
      }
      return [];
    } on DioException catch (e) {
      print('Error obteniendo mis detecciones: ${e.message}');
      return [];
    }
  }
}
