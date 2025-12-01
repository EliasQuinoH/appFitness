// lib/data/remote/models/user_model.dart
class UserModel {
  final int id;
  final String email;
  final String nombreUsuario;
  final String? nombreCompleto;
  final String tipoUsuario;
  final DateTime? fechaNacimiento;
  final String nivelFisicoActual;
  final int puntosExperiencia;
  final int cristalesMagicos;
  final int? rangoActual;
  final DateTime fechaRegistro;
  final DateTime ultimoAcceso;
  final bool estaActivo;

  UserModel({
    required this.id,
    required this.email,
    required this.nombreUsuario,
    this.nombreCompleto,
    required this.tipoUsuario,
    this.fechaNacimiento,
    required this.nivelFisicoActual,
    required this.puntosExperiencia,
    required this.cristalesMagicos,
    this.rangoActual,
    required this.fechaRegistro,
    required this.ultimoAcceso,
    required this.estaActivo,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      nombreUsuario: json['nombre_usuario'],
      nombreCompleto: json['nombre_completo'],
      tipoUsuario: json['tipo_usuario'],
      fechaNacimiento: json['fecha_nacimiento'] != null
          ? DateTime.parse(json['fecha_nacimiento'])
          : null,
      nivelFisicoActual: json['nivel_fisico_actual'],
      puntosExperiencia: json['puntos_experiencia'],
      cristalesMagicos: json['cristales_magicos'],
      rangoActual: json['rango_actual'],
      fechaRegistro: DateTime.parse(json['fecha_registro']),
      ultimoAcceso: DateTime.parse(json['ultimo_acceso']),
      estaActivo: json['esta_activo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'nombre_usuario': nombreUsuario,
      'nombre_completo': nombreCompleto,
      'tipo_usuario': tipoUsuario,
      'fecha_nacimiento': fechaNacimiento?.toIso8601String(),
      'nivel_fisico_actual': nivelFisicoActual,
      'puntos_experiencia': puntosExperiencia,
      'cristales_magicos': cristalesMagicos,
      'rango_actual': rangoActual,
      'fecha_registro': fechaRegistro.toIso8601String(),
      'ultimo_acceso': ultimoAcceso.toIso8601String(),
      'esta_activo': estaActivo,
    };
  }
}
