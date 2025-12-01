class EjercicioModel {
  final int id;
  final String nombre;
  final String? descripcion;
  final String tipo;
  final String tipoDisplay;
  final String? grupoMuscular;
  final String? grupoMuscularDisplay;
  final String? instrucciones;
  final String? videoUrl;
  final String? imagenUrl;
  final int duracionEstimadaMinutos;
  final double caloriasEstimadasPorMinuto;
  final int dificultadEstimada;

  EjercicioModel({
    required this.id,
    required this.nombre,
    this.descripcion,
    required this.tipo,
    required this.tipoDisplay,
    this.grupoMuscular,
    this.grupoMuscularDisplay,
    this.instrucciones,
    this.videoUrl,
    this.imagenUrl,
    required this.duracionEstimadaMinutos,
    required this.caloriasEstimadasPorMinuto,
    required this.dificultadEstimada,
  });

  factory EjercicioModel.fromJson(Map<String, dynamic> json) {
    return EjercicioModel(
      id: json['id'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      tipo: json['tipo'],
      tipoDisplay: json['tipo_display'] ?? json['tipo'],
      grupoMuscular: json['grupo_muscular'],
      grupoMuscularDisplay: json['grupo_muscular_display'],
      instrucciones: json['instrucciones'],
      videoUrl: json['video_url'],
      imagenUrl: json['imagen_url'],
      duracionEstimadaMinutos: json['duracion_estimada_minutos'],
      caloriasEstimadasPorMinuto:
          (json['calorias_estimadas_por_minuto'] is String)
          ? double.tryParse(json['calorias_estimadas_por_minuto']) ?? 0.0
          : json['calorias_estimadas_por_minuto']?.toDouble() ?? 0.0,
      dificultadEstimada: json['dificultad_estimada'] ?? 2,
    );
  }
}
