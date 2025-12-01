//mobile\lib\data\remote\geminis_api.dart
import 'package:flutter/foundation.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiAPI {
  static const String _apiKey = "AIzaSyD5QGz1jzx8KeQ7yxoSy89s99UwYGLQTsY";

  static late final GenerativeModel _model;

  /// Inicializa el modelo (llamar solo una vez en main)
  static void initialize() {
    _model = GenerativeModel(
      model: 'gemini-2.5-flash', // o gemini-2.5-flash si lo tienes habilitado
      apiKey: _apiKey,
    );
    debugPrint("GeminiAPI inicializado correctamente.");
  }

  /// Enviar prompt y obtener respuesta
  static Future<String?> generate(String prompt) async {
    try {
      final response = await _model.generateContent([Content.text(prompt)]);
      return response.text?.trim();
    } catch (e) {
      debugPrint("❌ Error en Gemini: $e");
      return null;
    }
  }
}
