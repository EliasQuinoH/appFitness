import 'package:dio/dio.dart';
import 'server.dart';

// Modelo para misión (fuera de la clase)
class MisionModel {
  final int id;
  final String titulo;
  final String descripcion;
  final String tipoMision;
  final int objetivo;
  final String unidadObjetivo;
  final int recompensaXp;
  final int recompensaCristales;
  final String dificultad;
  final bool estaActiva;
  final bool estaVigente;

  MisionModel({
    required this.id,
    required this.titulo,
    required this.descripcion,
    required this.tipoMision,
    required this.objetivo,
    required this.unidadObjetivo,
    required this.recompensaXp,
    required this.recompensaCristales,
    required this.dificultad,
    required this.estaActiva,
    required this.estaVigente,
  });

  factory MisionModel.fromJson(Map<String, dynamic> json) {
    return MisionModel(
      id: json['id'],
      titulo: json['titulo'],
      descripcion: json['descripcion'],
      tipoMision: json['tipo_mision'],
      objetivo: json['objetivo'],
      unidadObjetivo: json['unidad_objetivo'],
      recompensaXp: json['recompensa_xp'],
      recompensaCristales: json['recompensa_cristales'],
      dificultad: json['dificultad'],
      estaActiva: json['esta_activa'],
      estaVigente: json['esta_vigente'],
    );
  }
}

// Modelo para progreso de misión (fuera de la clase)
class ProgresoMisionModel {
  final int id;
  final int misionId;
  final String misionTitulo;
  final int progresoActual;
  final int misionObjetivo;
  final bool completada;
  final int porcentajeCompletado;

  ProgresoMisionModel({
    required this.id,
    required this.misionId,
    required this.misionTitulo,
    required this.progresoActual,
    required this.misionObjetivo,
    required this.completada,
    required this.porcentajeCompletado,
  });

  factory ProgresoMisionModel.fromJson(Map<String, dynamic> json) {
    return ProgresoMisionModel(
      id: json['id'],
      misionId: json['mision'],
      misionTitulo: json['mision_titulo'] ?? '',
      progresoActual: json['progreso_actual'],
      misionObjetivo: json['mision_objetivo'],
      completada: json['completada'],
      porcentajeCompletado: json['porcentaje_completado'],
    );
  }
}

class MisionService {
  final Servidor _servidor = Servidor();

  Future<List<MisionModel>> getMisionesDisponibles() async {
    try {
      final response = await _servidor.dio.get('/misiones/disponibles/');

      if (response.statusCode == 200) {
        // Esta es un action, probablemente sin paginación
        final data = response.data;
        if (data is List) {
          return data.map((json) => MisionModel.fromJson(json)).toList();
        }
        // Por si acaso tiene paginación
        if (data['results'] != null) {
          final List<dynamic> results = data['results'];
          return results.map((json) => MisionModel.fromJson(json)).toList();
        }
        return [];
      }
      return [];
    } on DioException catch (e) {
      print('Error obteniendo misiones: ${e.message}');
      return [];
    }
  }

  Future<List<ProgresoMisionModel>> getMisMisiones() async {
    try {
      final response = await _servidor.dio.get('/progreso-misiones/');

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['results'] != null) {
          final List<dynamic> results = data['results'];
          return results
              .map((json) => ProgresoMisionModel.fromJson(json))
              .toList();
        }
        return [];
      }
      return [];
    } on DioException catch (e) {
      print('Error obteniendo mis misiones: ${e.message}');
      return [];
    }
  }

  Future<List<ProgresoMisionModel>> getMisionesActivas() async {
    //Falta modificar
    try {
      final response = await _servidor.dio.get('/progreso-misiones/activas/');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => ProgresoMisionModel.fromJson(json)).toList();
      }
      return [];
    } on DioException catch (e) {
      print('Error obteniendo misiones activas: ${e.message}');
      return [];
    }
  }

  Future<List<ProgresoMisionModel>> getMisionesCompletadas() async {
    //Falta modificar
    try {
      final response = await _servidor.dio.get(
        '/progreso-misiones/completadas/',
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => ProgresoMisionModel.fromJson(json)).toList();
      }
      return [];
    } on DioException catch (e) {
      print('Error obteniendo misiones completadas: ${e.message}');
      return [];
    }
  }

  Future<bool> actualizarProgresoMision(int progresoId, int incremento) async {
    try {
      final response = await _servidor.dio.post(
        '/progreso-misiones/$progresoId/actualizar_progreso/',
        data: {'incremento': incremento},
      );

      return response.statusCode == 200;
    } on DioException catch (e) {
      print('Error actualizando progreso: ${e.message}');
      return false;
    }
  }
}
