// mobile/lib/presentation/workout/detectors/squat_detector.dart
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import '../pose_math.dart';

//detector de sentadillas
class SquatDetector {
  int reps = 0;
  bool _isDown = false;

  // Nuevo rango más realista
  final double kneeDownAngle = 110; // bajar cuando la rodilla < 110°
  final double kneeUpAngle = 155; // subir cuando rodilla > 155°
  final double torsoTolerance = 35; // tolerancia más realista

  void detectSquat(List<Pose> poses) {
    if (poses.isEmpty) return;
    final pose = poses.first;

    // Validar landmarks críticos
    final landmarksNeeded = [
      PoseLandmarkType.leftHip,
      PoseLandmarkType.rightHip,
      PoseLandmarkType.leftShoulder,
      PoseLandmarkType.rightShoulder,
      PoseLandmarkType.leftKnee,
      PoseLandmarkType.rightKnee,
      PoseLandmarkType.leftAnkle,
      PoseLandmarkType.rightAnkle,
    ];

    for (var lm in landmarksNeeded) {
      if (pose.landmarks[lm] == null) return;
    }

    // Ángulo de rodilla (promedio para estabilidad)
    final leftKnee = angleBetweenJoints(
      pose.landmarks[PoseLandmarkType.leftHip]!,
      pose.landmarks[PoseLandmarkType.leftKnee]!,
      pose.landmarks[PoseLandmarkType.leftAnkle]!,
    );

    final rightKnee = angleBetweenJoints(
      pose.landmarks[PoseLandmarkType.rightHip]!,
      pose.landmarks[PoseLandmarkType.rightKnee]!,
      pose.landmarks[PoseLandmarkType.rightAnkle]!,
    );

    final kneeAngle = (leftKnee + rightKnee) / 2;

    // Ángulo del torso
    final torsoAngle = angleBetweenJoints(
      pose.landmarks[PoseLandmarkType.leftShoulder]!,
      pose.landmarks[PoseLandmarkType.leftHip]!,
      pose.landmarks[PoseLandmarkType.leftKnee]!,
    );

    // Permitir torso ligeramente inclinado hacia adelante (muy común)
    final torsoIsValid = (torsoAngle - 180).abs() < torsoTolerance;
    if (!torsoIsValid) return;

    // Detectar bajada
    if (kneeAngle < kneeDownAngle && !_isDown) {
      _isDown = true;
    }

    // Detectar subida
    if (kneeAngle > kneeUpAngle && _isDown) {
      reps += 1;
      _isDown = false;
    }
  }
}
