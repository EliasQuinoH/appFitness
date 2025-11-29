//mobile\lib\data\remote\geminis_api.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../data/local/database.dart'; // Asegúrate de importar la base de datos

class GeminiAPI {
  static const String _endpoint =
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash-preview-09-2025:generateContent";
  static const String _apiKey = "AIzaSyCBKq70Sw_pgdrlTssGCKuFyOR_meZUAuU";

  /// Genera una rutina de ejercicios según el perfil del usuario
  static Future<String?> generateRoutine({
    required double weight,
    required double height,
    int? age,
    String? issues,
    String? pains,
    required List<ExerciseTableData>
    exercises, // Usamos la clase ExerciseTableData para los ejercicios
  }) async {
    // Generamos la lista de ejercicios disponibles para incluirlos en el prompt
    final exerciseList = exercises.map((e) => e.name).join(", ");

    // Creamos el prompt para la API de Gemini incluyendo los ejercicios disponibles
    final prompt =
        """
Usuario con peso ${weight}kg, altura ${height}cm, edad ${age ?? 'N/A'}.
Enfermedades: ${issues ?? 'ninguna'}.
Dolores: ${pains ?? 'ninguno'}.
Genera una rutina de ejercicios con los siguientes ejercicios: $exerciseList.
Incluye repeticiones y series para cada ejercicio.
""";

    final body = jsonEncode({
      "contents": [
        {
          "parts": [
            {"text": prompt},
          ],
        },
      ],
    });

    try {
      final response = await http.post(
        Uri.parse(_endpoint),
        headers: {
          "Content-Type": "application/json",
          "X-goog-api-key": _apiKey,
        },
        body: body,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // El texto generado normalmente está aquí:
        final outputText = data['candidates']?[0]?['content']?[0]?['text'];
        return outputText?.toString();
      } else {
        print("Error Gemini API: ${response.statusCode}");
        print(response.body);
        return null;
      }
    } catch (e) {
      print("Excepción al llamar Gemini API: $e");
      return null;
    }
  }
}
