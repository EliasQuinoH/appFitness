class RutinaModel {
  final int id;
  final String nombre;
  final String? descripcion;
  final String nivelDificultad;
  final int duracionMinutos;
  final String tipoEjercicio;
  final int caloriasEstimadas;
  final bool esPublica;
  final int creador;
  final bool estaActiva;

  RutinaModel({
    required this.id,
    required this.nombre,
    this.descripcion,
    required this.nivelDificultad,
    required this.duracionMinutos,
    required this.tipoEjercicio,
    required this.caloriasEstimadas,
    required this.esPublica,
    required this.creador,
    required this.estaActiva,
  });

  factory RutinaModel.fromJson(Map<String, dynamic> json) {
    return RutinaModel(
      id: json['id'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      nivelDificultad: json['nivel_dificultad'],
      duracionMinutos: json['duracion_minutos'],
      tipoEjercicio: json['tipo_ejercicio'],
      caloriasEstimadas: json['calorias_estimadas'],
      esPublica: json['es_publica'],
      creador: json['creador'],
      estaActiva: json['esta_activa'],
    );
  }
}
