//mobile\lib\services\rutina_service.dart
import 'package:dio/dio.dart';
import '../data/remote/models/rutina_model.dart';
import '../data/remote/models/ejercicio_model.dart';
import 'server.dart';

// Modelo para ejercicio dentro de rutina (fuera de la clase)
class EjercicioEnRutina {
  final int id;
  final EjercicioModel ejercicio;
  final int orden;
  final int series;
  final String repeticiones;
  final int descansoSegundos;
  final double? pesoSugerido;
  final String? notas;
  final double duracionEstimadaMinutos;

  EjercicioEnRutina({
    required this.id,
    required this.ejercicio,
    required this.orden,
    required this.series,
    required this.repeticiones,
    required this.descansoSegundos,
    this.pesoSugerido,
    this.notas,
    required this.duracionEstimadaMinutos,
  });

  factory EjercicioEnRutina.fromJson(Map<String, dynamic> json) {
    return EjercicioEnRutina(
      id: json['id'],
      ejercicio: EjercicioModel.fromJson(json['ejercicio']),
      orden: json['orden'],
      series: json['series'],
      repeticiones: json['repeticiones'],
      descansoSegundos: json['descanso_segundos'],
      pesoSugerido: json['peso_sugerido']?.toDouble(),
      notas: json['notas'],
      duracionEstimadaMinutos:
          json['duracion_estimada_minutos']?.toDouble() ?? 0.0,
    );
  }
}

class RutinaService {
  final Servidor _servidor = Servidor();

  Future<List<RutinaModel>> getRutinas() async {
    try {
      final response = await _servidor.dio.get('/rutinas/');

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['results'] != null) {
          final List<dynamic> results = data['results'];
          return results.map((json) => RutinaModel.fromJson(json)).toList();
        }
        return [];
      }
      return [];
    } on DioException catch (e) {
      print('Error obteniendo rutinas: ${e.message}');
      return [];
    }
  }

  Future<RutinaModel?> getRutinaById(int id) async {
    try {
      final response = await _servidor.dio.get('/rutinas/$id/');

      if (response.statusCode == 200) {
        return RutinaModel.fromJson(response.data);
      }
      return null;
    } on DioException catch (e) {
      print('Error obteniendo rutina: ${e.message}');
      return null;
    }
  }

  Future<List<EjercicioEnRutina>> getEjerciciosDeRutina(int rutinaId) async {
    try {
      final response = await _servidor.dio.get('/rutinas/$rutinaId/');

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['ejercicios'] != null) {
          final List<dynamic> ejerciciosJson = data['ejercicios'];
          return ejerciciosJson
              .map((json) => EjercicioEnRutina.fromJson(json))
              .toList();
        }
      }
      return [];
    } on DioException catch (e) {
      print('Error obteniendo ejercicios de rutina: ${e.message}');
      return [];
    }
  }

  Future<bool> asignarRutinaAMi(int rutinaId) async {
    try {
      final response = await _servidor.dio.post(
        '/rutinas/$rutinaId/asignar_a_mi/',
      );

      return response.statusCode == 201 || response.statusCode == 200;
    } on DioException catch (e) {
      print('Error asignando rutina: ${e.message}');
      return false;
    }
  }

  Future<List<RutinaModel>> getRutinasAsignadas() async {
    try {
      final response = await _servidor.dio.get('/asignaciones-rutina/');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;

        // Extraer las rutinas de las asignaciones
        final List<RutinaModel> rutinas = [];
        for (var asignacion in data) {
          if (asignacion['rutina'] != null) {
            rutinas.add(RutinaModel.fromJson(asignacion['rutina']));
          }
        }
        return rutinas;
      }
      return [];
    } on DioException catch (e) {
      print('Error obteniendo rutinas asignadas: ${e.message}');
      return [];
    }
  }

  Future<List<RutinaModel>> getRutinasPendientes() async {
    try {
      final response = await _servidor.dio.get(
        '/asignaciones-rutina/pendientes/',
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => RutinaModel.fromJson(json)).toList();
      }
      return [];
    } on DioException catch (e) {
      print('Error obteniendo rutinas pendientes: ${e.message}');
      return [];
    }
  }

  Future<List<RutinaModel>> getRutinasCompletadas() async {
    try {
      final response = await _servidor.dio.get(
        '/asignaciones-rutina/completadas/',
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => RutinaModel.fromJson(json)).toList();
      }
      return [];
    } on DioException catch (e) {
      print('Error obteniendo rutinas completadas: ${e.message}');
      return [];
    }
  }

  Future<bool> marcarRutinaCompletada(
    int asignacionId, {
    int? calificacion,
    String? notas,
  }) async {
    try {
      final response = await _servidor.dio.post(
        '/asignaciones-rutina/$asignacionId/marcar_completada/',
        data: {'calificacion_dificultad': calificacion, 'notas_usuario': notas},
      );

      return response.statusCode == 200;
    } on DioException catch (e) {
      print('Error marcando rutina completada: ${e.message}');
      return false;
    }
  }
}
