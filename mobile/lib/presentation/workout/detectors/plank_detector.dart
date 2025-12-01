//mobile\lib\presentation\workout\detectors\plank_detector.dart
// mobile/lib/presentation/workout/detectors/plank_detector.dart
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import '../pose_math.dart';

class PlankDetector {
  bool isPlankCorrect = false;
  DateTime? _startTime;
  Duration totalTime = Duration.zero;

  /// Límite de ángulo torso-piernas para considerar cuerpo recto
  final double maxBodyBendAngle = 15; // grados (tolerancia)
  /// Límite de inclinación del torso para horizontal
  final double maxTorsoSlope = 0.9; // ajusta según pruebas

  /// Detecta la plancha y mide el tiempo
  void detectPlank(List<Pose> poses) {
    if (poses.isEmpty) {
      _stopTimer();
      return;
    }

    final pose = poses.first;

    // Ángulo torso-piernas
    final bodyAngle = angleBetweenJoints(
      pose.landmarks[PoseLandmarkType.leftShoulder],
      pose.landmarks[PoseLandmarkType.leftHip],
      pose.landmarks[PoseLandmarkType.leftAnkle],
    );

    final bodyIsStraight = (bodyAngle - 180).abs() < maxBodyBendAngle;

    // Pendiente torso (horizontal)
    final torsoSlope = _calculateTorsoSlope(pose);
    final isHorizontal = torsoSlope < maxTorsoSlope;

    // Si la posición es correcta
    if (bodyIsStraight && isHorizontal) {
      isPlankCorrect = true;
      _startTimer();
    } else {
      isPlankCorrect = false;
      _stopTimer();
    }
  }

  /// Calcula la pendiente del torso (0 = horizontal)
  double _calculateTorsoSlope(Pose pose) {
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

    final shoulderY = (leftShoulder.y + rightShoulder.y) / 2;
    final shoulderX = (leftShoulder.x + rightShoulder.x) / 2;
    final hipY = (leftHip.y + rightHip.y) / 2;
    final hipX = (leftHip.x + rightHip.x) / 2;

    final slope = (hipY - shoulderY) / (hipX - shoulderX + 0.0001);
    return slope.abs();
  }

  /// Inicia el temporizador de plancha
  void _startTimer() {
    if (_startTime == null) {
      _startTime = DateTime.now();
    } else {
      final now = DateTime.now();
      totalTime += now.difference(_startTime!);
      _startTime = now;
    }
  }

  /// Detiene el temporizador
  void _stopTimer() {
    _startTime = null;
  }

  /// Devuelve el tiempo total en segundos
  int getTimeSeconds() {
    return totalTime.inSeconds;
  }
}
