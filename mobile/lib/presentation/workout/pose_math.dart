// mobile/lib/presentation/workout/pose_math.dart
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'dart:math';
import 'dart:ui'; // <- para Offset

/// Calcula el ángulo en grados formado por tres landmarks
/// Pasa los puntos como (proximal - joint - distal)
double angleBetweenJoints(
  PoseLandmark? joint1,
  PoseLandmark? joint2,
  PoseLandmark? joint3,
) {
  if (joint1 == null || joint2 == null || joint3 == null) return 0.0;

  final vectorA = Offset(joint1.x - joint2.x, joint1.y - joint2.y);
  final vectorB = Offset(joint3.x - joint2.x, joint3.y - joint2.y);

  final dotProduct = vectorA.dx * vectorB.dx + vectorA.dy * vectorB.dy;
  final magnitudeA = sqrt(vectorA.dx * vectorA.dx + vectorA.dy * vectorA.dy);
  final magnitudeB = sqrt(vectorB.dx * vectorB.dx + vectorB.dy * vectorB.dy);

  if (magnitudeA == 0 || magnitudeB == 0) return 0.0;

  final cosAngle = dotProduct / (magnitudeA * magnitudeB);

  // Asegurarse que esté entre -1 y 1 para acos
  final clampedCos = cosAngle.clamp(-1.0, 1.0);

  final angleRad = acos(clampedCos);

  return angleRad * (180 / pi); // convertir a grados
}

/// Calcula la distancia entre dos landmarks
double distanceBetweenJoints(PoseLandmark? joint1, PoseLandmark? joint2) {
  if (joint1 == null || joint2 == null) return 0.0;
  final dx = joint1.x - joint2.x;
  final dy = joint1.y - joint2.y;
  return sqrt(dx * dx + dy * dy);
}

/// Devuelve la media de varios ángulos
double averageAngle(List<double> angles) {
  if (angles.isEmpty) return 0.0;
  return angles.reduce((a, b) => a + b) / angles.length;
}

/// Comprueba si un ángulo está dentro de un rango
bool isAngleWithinRange(double angle, double min, double max) {
  return angle >= min && angle <= max;
}
