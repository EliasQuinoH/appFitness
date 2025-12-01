// mobile/lib/presentation/workout/detectors/pushup_detector.dart
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import '../pose_math.dart';
import 'dart:math';

class PushUpDetector {
  int reps = 0;
  bool _isDown = false;

  /// Límite de ángulo para considerar brazos doblados
  final double elbowDownAngle = 90; // grados
  final double elbowUpAngle = 160; // grados

  /// Límite para considerar cuerpo recto
  final double maxBodyBendAngle = 15; // grados (tolerancia)

  /// Tolerancia de inclinación del torso para horizontal
  final double maxTorsoAngle = 0.9; // en radianes (~28.6°)

  /// Detecta flexión y cuenta repeticiones
  void detectPushUp(List<Pose> poses) {
    if (poses.isEmpty) return;
    final pose = poses.first;

    // Ángulos de codos
    final leftElbow = angleBetweenJoints(
      pose.landmarks[PoseLandmarkType.leftShoulder],
      pose.landmarks[PoseLandmarkType.leftElbow],
      pose.landmarks[PoseLandmarkType.leftWrist],
    );

    final rightElbow = angleBetweenJoints(
      pose.landmarks[PoseLandmarkType.rightShoulder],
      pose.landmarks[PoseLandmarkType.rightElbow],
      pose.landmarks[PoseLandmarkType.rightWrist],
    );

    // Ángulo torso-piernas para cuerpo recto
    final bodyAngle = angleBetweenJoints(
      pose.landmarks[PoseLandmarkType.leftShoulder],
      pose.landmarks[PoseLandmarkType.leftHip],
      pose.landmarks[PoseLandmarkType.leftAnkle],
    );
    final bodyIsStraight = (bodyAngle - 180).abs() < maxBodyBendAngle;

    // Inclinación del torso (para horizontalidad)
    final torsoAngle = _calculateTorsoAngle(pose);
    final isHorizontal = torsoAngle < maxTorsoAngle;

    // No contar si el cuerpo no está recto o no horizontal
    if (!bodyIsStraight || !isHorizontal) return;

    // Promedio de ángulos de codo
    final avgElbow = (leftElbow + rightElbow) / 2;

    if (avgElbow < elbowDownAngle && !_isDown) {
      _isDown = true; // Empieza la bajada
    }

    if (avgElbow > elbowUpAngle && _isDown) {
      reps += 1; // Repetición completada
      _isDown = false;
    }
  }

  /// Calcula la inclinación del torso respecto horizontal (0 = perfecto horizontal)
  double _calculateTorsoAngle(Pose pose) {
    final leftShoulder = pose.landmarks[PoseLandmarkType.leftShoulder];
    final rightShoulder = pose.landmarks[PoseLandmarkType.rightShoulder];
    final leftHip = pose.landmarks[PoseLandmarkType.leftHip];
    final rightHip = pose.landmarks[PoseLandmarkType.rightHip];

    if (leftShoulder == null ||
        rightShoulder == null ||
        leftHip == null ||
        rightHip == null) {
      return double.infinity;
    }

    // Centro de hombros y caderas
    final shoulderY = (leftShoulder.y + rightShoulder.y) / 2;
    final shoulderX = (leftShoulder.x + rightShoulder.x) / 2;
    final hipY = (leftHip.y + rightHip.y) / 2;
    final hipX = (leftHip.x + rightHip.x) / 2;

    // Ángulo respecto horizontal
    final angle = atan2(hipY - shoulderY, hipX - shoulderX);
    return angle.abs(); // en radianes
  }
}
