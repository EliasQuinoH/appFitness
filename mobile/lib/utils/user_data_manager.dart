// lib/utils/user_data_manager.dart
import 'package:flutter/material.dart';

class UserDataManager extends ChangeNotifier {
  static final UserDataManager _instance = UserDataManager._internal();
  factory UserDataManager() => _instance;
  UserDataManager._internal();

  // Datos del usuario
  int _puntosExperiencia = 0;
  int _cristalesMagicos = 0;
  String _nombreUsuario = '';

  // Getters
  int get puntosExperiencia => _puntosExperiencia;
  int get cristalesMagicos => _cristalesMagicos;
  String get nombreUsuario => _nombreUsuario;

  // Setters que notifican cambios
  void setDatosUsuario({
    int? puntosExperiencia,
    int? cristalesMagicos,
    String? nombreUsuario,
  }) {
    if (puntosExperiencia != null) {
      _puntosExperiencia = puntosExperiencia;
    }
    if (cristalesMagicos != null) {
      _cristalesMagicos = cristalesMagicos;
    }
    if (nombreUsuario != null) {
      _nombreUsuario = nombreUsuario;
    }
    notifyListeners();
  }

  void agregarPuntos(int puntos) {
    _puntosExperiencia += puntos;
    notifyListeners();
    print('➕ Puntos agregados: $puntos. Total: $_puntosExperiencia');
  }

  void agregarCristales(int cristales) {
    _cristalesMagicos += cristales;
    notifyListeners();
    print('💎 Cristales agregados: $cristales. Total: $_cristalesMagicos');
  }

  // Cargar datos iniciales
  void cargarDatosIniciales(Map<String, dynamic> userData) {
    _puntosExperiencia = userData['puntos_experiencia'] ?? 0;
    _cristalesMagicos = userData['cristales_magicos'] ?? 0;
    _nombreUsuario = userData['nombre_usuario'] ?? '';
    notifyListeners();
  }
}
