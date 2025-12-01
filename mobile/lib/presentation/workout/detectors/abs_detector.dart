//mobile\lib\presentation\workout\detectors\abs_detector.dart
// mobile/lib/presentation/workout/detectors/abs_detector.dart
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import '../pose_math.dart';

// detector de abdominales

class AbsDetector {
  int reps = 0;
  bool _isUp = false;

  /// Ángulo para considerar torso levantado
  final double torsoUpAngle = 50; // grados
  /// Ángulo para considerar torso bajado
  final double torsoDownAngle = 130; // grados

  /// Máxima inclinación lateral del torso
  final double maxTorsoBend = 20; // grados

  void detectAbs(List<Pose> poses) {
    if (poses.isEmpty) return;
    final pose = poses.first;

    // Validar landmarks críticos
    final landmarks = [
      PoseLandmarkType.leftShoulder,
      PoseLandmarkType.rightShoulder,
      PoseLandmarkType.leftHip,
      PoseLandmarkType.rightHip,
      PoseLandmarkType.leftKnee,
      PoseLandmarkType.rightKnee,
      PoseLandmarkType.leftAnkle,
      PoseLandmarkType.rightAnkle,
    ];

    for (var lm in landmarks) {
      if (pose.landmarks[lm] == null) return;
    }

    // Ángulo torso (hombro - cadera - rodilla)
    final leftTorsoAngle = angleBetweenJoints(
      pose.landmarks[PoseLandmarkType.leftShoulder]!,
      pose.landmarks[PoseLandmarkType.leftHip]!,
      pose.landmarks[PoseLandmarkType.leftKnee]!,
    );

    final rightTorsoAngle = angleBetweenJoints(
      pose.landmarks[PoseLandmarkType.rightShoulder]!,
      pose.landmarks[PoseLandmarkType.rightHip]!,
      pose.landmarks[PoseLandmarkType.rightKnee]!,
    );

    // Promedio del ángulo del torso
    final torsoAngle = (leftTorsoAngle + rightTorsoAngle) / 2;

    // Verificar inclinación lateral
    final lateralBend = (leftTorsoAngle - rightTorsoAngle).abs();
    if (lateralBend > maxTorsoBend) return; // demasiado inclinado, no contar

    // Detectar subida
    if (torsoAngle < torsoUpAngle && !_isUp) {
      _isUp = true; // Subida completa
    }

    // Detectar bajada
    if (torsoAngle > torsoDownAngle && _isUp) {
      reps += 1; // Repetición completada
      _isUp = false;
    }
  }
}
