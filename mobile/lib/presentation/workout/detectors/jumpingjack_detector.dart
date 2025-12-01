// mobile/lib/presentation/workout/detectors/jumpingjack_detector.dart
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'dart:math';
import '../pose_math.dart';

// Detector de saltos tijera (Jumping Jack) basado en posición y distancia normalizada (ratios).
class JumpingJackDetector {
  int reps = 0;
  bool _isOpen = false;

  /// Máxima inclinación del torso permitida (para forma correcta)
  final double maxTorsoBend = 20; // grados

  /// Proporción mínima de ancho entre tobillos y caderas para considerarse "abierto"
  /// Tobillo ancho debe ser al menos 1.3 veces (130%) la distancia de cadera.
  final double minLegsSpreadRatio = 1.3;

  /// Posición vertical mínima de la muñeca respecto al hombro para considerarse "brazos arriba"
  /// Usamos 0.15 como un umbral seguro, la muñeca debe estar notablemente por encima del hombro.
  final double minHandRaiseThreshold = 0.15;

  /// Helper: Calcula la distancia euclidiana entre dos landmarks.
  double _distance(PoseLandmark lm1, PoseLandmark lm2) {
    return sqrt(pow(lm1.x - lm2.x, 2) + pow(lm1.y - lm2.y, 2));
  }

  void detectJumpingJack(List<Pose> poses) {
    if (poses.isEmpty) return;
    final pose = poses.first;

    // Validación y obtención de landmarks críticos
    final requiredLandmarks = {
      PoseLandmarkType.leftShoulder,
      PoseLandmarkType.rightShoulder,
      PoseLandmarkType.leftHip,
      PoseLandmarkType.rightHip,
      PoseLandmarkType.leftAnkle,
      PoseLandmarkType.rightAnkle,
      PoseLandmarkType.leftWrist,
      PoseLandmarkType.rightWrist,
      PoseLandmarkType.leftKnee,
      PoseLandmarkType.rightKnee,
    };

    final landmarksMap = pose.landmarks;

    // Comprobar que todos los landmarks existan
    for (var type in requiredLandmarks) {
      if (landmarksMap[type] == null) return;
    }

    final lHip = landmarksMap[PoseLandmarkType.leftHip]!;
    final rHip = landmarksMap[PoseLandmarkType.rightHip]!;
    final lAnkle = landmarksMap[PoseLandmarkType.leftAnkle]!;
    final rAnkle = landmarksMap[PoseLandmarkType.rightAnkle]!;
    final lShoulder = landmarksMap[PoseLandmarkType.leftShoulder]!;
    final rShoulder = landmarksMap[PoseLandmarkType.rightShoulder]!;
    final lWrist = landmarksMap[PoseLandmarkType.leftWrist]!;
    final rWrist = landmarksMap[PoseLandmarkType.rightWrist]!;

    // --- 1. VERIFICACIÓN DE LA FORMA (Torso Recto) ---
    // Usamos el ángulo de la cadera izquierda (Hombro - Cadera - Rodilla)
    final torsoAngle = angleBetweenJoints(
      lShoulder,
      lHip,
      landmarksMap[PoseLandmarkType.leftKnee]!,
    );
    // Un torso recto significa que el ángulo es cerca de 180 grados.
    final torsoIsStraight = (torsoAngle - 180).abs() < maxTorsoBend;
    if (!torsoIsStraight) return;

    // --- 2. VERIFICACIÓN DE LA POSICIÓN ---

    // a) POSICIÓN DE BRAZOS (Arriba vs. Abajo)
    // Usamos la coordenada Y (el eje Y en ML Kit aumenta hacia abajo)
    // Brazos arriba = Muñeca Y (menor) que Hombro Y. Normalizamos por la altura de la cabeza-cadera
    // Para simplificar, usamos la diferencia Y absoluta (Y menor es más alto)

    // Altura del hombro a la muñeca (diferencia Y, cuanto más negativa, más arriba)
    final leftHandHeightDiff = lWrist.y - lShoulder.y;
    final rightHandHeightDiff = rWrist.y - rShoulder.y;

    // El umbral se aplica en el eje Y. Si la diferencia es un valor negativo grande, están arriba.
    // Usamos la anchura del hombro como factor de normalización.
    final shoulderWidth = _distance(lShoulder, rShoulder);
    final normalizedThreshold = minHandRaiseThreshold * shoulderWidth;

    final armsAreUp =
        leftHandHeightDiff < -normalizedThreshold &&
        rightHandHeightDiff < -normalizedThreshold;

    // Brazos abajo (cerrado) = Muñeca Y (mayor) que Hombro Y (o muy cerca)
    final armsAreDown = leftHandHeightDiff > 0 && rightHandHeightDiff > 0;

    // b) POSICIÓN DE PIERNAS (Abiertas vs. Cerradas)
    // Usamos la distancia horizontal de los tobillos relativa a la anchura de la cadera.
    final hipWidth = _distance(lHip, rHip);
    final ankleWidth = _distance(lAnkle, rAnkle);

    // Piernas Abiertas: El ancho del tobillo es significativamente mayor que el ancho de la cadera.
    final legsAreWide = ankleWidth > hipWidth * minLegsSpreadRatio;

    // Piernas Cerradas: El ancho del tobillo es igual o menor que el ancho de la cadera (pies juntos o muy cerca).
    final legsAreTogether = ankleWidth < hipWidth;

    // --- 3. DETECCIÓN DEL CICLO ---

    final allOpen = armsAreUp && legsAreWide;
    final allClosed = armsAreDown && legsAreTogether;

    // FASE 1: Se abrió completamente (Abre los brazos Y las piernas)
    if (allOpen && !_isOpen) {
      _isOpen = true;
    }

    // FASE 2: Se cerró completamente (completa la repetición)
    // Solo contamos si antes estuvo en la fase abierta (_isOpen == true)
    if (allClosed && _isOpen) {
      reps += 1;
      _isOpen = false;
    }
  }
}
