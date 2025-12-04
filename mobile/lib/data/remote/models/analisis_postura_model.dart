class AnalisisPostura {
  final Map<String, dynamic> puntosCorporales;
  final double precision;
  final int puntuacion;
  final String ejercicio;
  final int repeticiones;
  final double? duracionAnalisis;
  final Map<String, dynamic>? metadata;

  AnalisisPostura({
    required this.puntosCorporales,
    required this.precision,
    required this.puntuacion,
    required this.ejercicio,
    this.repeticiones = 0,
    this.duracionAnalisis,
    this.metadata,
  });

  Map<String, dynamic> toJson() {
    return {
      'puntos_corporales': puntosCorporales,
      'precision': precision,
      'puntuacion': puntuacion,
      'ejercicio': ejercicio,
      'repeticiones': repeticiones,
      if (duracionAnalisis != null) 'duracion_analisis': duracionAnalisis,
      if (metadata != null) 'metadata': metadata,
    };
  }
}
