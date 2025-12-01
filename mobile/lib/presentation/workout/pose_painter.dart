//mobile\lib\presentation\workout\pose_painter.dart
import 'package:flutter/material.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'package:camera/camera.dart';
import 'coordinates_translator.dart';

class PosePainter extends CustomPainter {
  PosePainter(
    this.poses,
    this.imageSize,
    this.rotation,
    this.cameraLensDirection,
  );

  final List<Pose> poses;
  final Size imageSize;
  final InputImageRotation rotation;
  final CameraLensDirection cameraLensDirection;

  @override
  void paint(Canvas canvas, Size size) {
    final landmarkPaint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 3.0
      ..color = Colors.green;

    final leftPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..color = Colors.yellow;

    final rightPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..color = Colors.blueAccent;

    for (final pose in poses) {
      // Dibujar cada landmark
      pose.landmarks.forEach((_, landmark) {
        canvas.drawCircle(
          Offset(
            translateX(
              landmark.x,
              size,
              imageSize,
              rotation,
              cameraLensDirection,
            ),
            translateY(
              landmark.y,
              size,
              imageSize,
              rotation,
              cameraLensDirection,
            ),
          ),
          4,
          landmarkPaint,
        );
      });

      // Función para dibujar línea entre dos landmarks
      void paintLine(
        PoseLandmarkType type1,
        PoseLandmarkType type2,
        Paint paintType,
      ) {
        final joint1 = pose.landmarks[type1];
        final joint2 = pose.landmarks[type2];
        if (joint1 == null || joint2 == null) return;

        canvas.drawLine(
          Offset(
            translateX(
              joint1.x,
              size,
              imageSize,
              rotation,
              cameraLensDirection,
            ),
            translateY(
              joint1.y,
              size,
              imageSize,
              rotation,
              cameraLensDirection,
            ),
          ),
          Offset(
            translateX(
              joint2.x,
              size,
              imageSize,
              rotation,
              cameraLensDirection,
            ),
            translateY(
              joint2.y,
              size,
              imageSize,
              rotation,
              cameraLensDirection,
            ),
          ),
          paintType,
        );
      }

      // Función para dibujar línea entre puntos personalizados (Offset)
      void paintLineCustom(Offset p1, Offset p2, Paint paintType) {
        canvas.drawLine(
          Offset(
            translateX(p1.dx, size, imageSize, rotation, cameraLensDirection),
            translateY(p1.dy, size, imageSize, rotation, cameraLensDirection),
          ),
          Offset(
            translateX(p2.dx, size, imageSize, rotation, cameraLensDirection),
            translateY(p2.dy, size, imageSize, rotation, cameraLensDirection),
          ),
          paintType,
        );
      }

      // --- Brazos ---
      paintLine(
        PoseLandmarkType.leftShoulder,
        PoseLandmarkType.leftElbow,
        leftPaint,
      );
      paintLine(
        PoseLandmarkType.leftElbow,
        PoseLandmarkType.leftWrist,
        leftPaint,
      );
      paintLine(
        PoseLandmarkType.rightShoulder,
        PoseLandmarkType.rightElbow,
        rightPaint,
      );
      paintLine(
        PoseLandmarkType.rightElbow,
        PoseLandmarkType.rightWrist,
        rightPaint,
      );

      // --- Torso ---
      paintLine(
        PoseLandmarkType.leftShoulder,
        PoseLandmarkType.leftHip,
        leftPaint,
      );
      paintLine(
        PoseLandmarkType.rightShoulder,
        PoseLandmarkType.rightHip,
        rightPaint,
      );

      // --- Piernas ---
      paintLine(PoseLandmarkType.leftHip, PoseLandmarkType.leftKnee, leftPaint);
      paintLine(
        PoseLandmarkType.leftKnee,
        PoseLandmarkType.leftAnkle,
        leftPaint,
      );
      paintLine(
        PoseLandmarkType.rightHip,
        PoseLandmarkType.rightKnee,
        rightPaint,
      );
      paintLine(
        PoseLandmarkType.rightKnee,
        PoseLandmarkType.rightAnkle,
        rightPaint,
      );

      // --- Cabeza al torso ---
      final nose = pose.landmarks[PoseLandmarkType.nose];
      final leftShoulder = pose.landmarks[PoseLandmarkType.leftShoulder];
      final rightShoulder = pose.landmarks[PoseLandmarkType.rightShoulder];
      if (nose != null) {
        if (leftShoulder != null)
          paintLine(
            PoseLandmarkType.nose,
            PoseLandmarkType.leftShoulder,
            landmarkPaint,
          );
        if (rightShoulder != null)
          paintLine(
            PoseLandmarkType.nose,
            PoseLandmarkType.rightShoulder,
            landmarkPaint,
          );
      }

      // --- Cintura central ---
      final leftHip = pose.landmarks[PoseLandmarkType.leftHip];
      final rightHip = pose.landmarks[PoseLandmarkType.rightHip];
      if (leftHip != null &&
          rightHip != null &&
          leftShoulder != null &&
          rightShoulder != null) {
        final midHip = Offset(
          (leftHip.x + rightHip.x) / 2,
          (leftHip.y + rightHip.y) / 2,
        );
        final midShoulder = Offset(
          (leftShoulder.x + rightShoulder.x) / 2,
          (leftShoulder.y + rightShoulder.y) / 2,
        );
        paintLineCustom(midHip, midShoulder, landmarkPaint);

        // --- Línea horizontal hombros ---
        paintLineCustom(
          Offset(leftShoulder.x, leftShoulder.y),
          Offset(rightShoulder.x, rightShoulder.y),
          landmarkPaint,
        );

        // --- Línea horizontal cintura ---
        paintLineCustom(
          Offset(leftHip.x, leftHip.y),
          Offset(rightHip.x, rightHip.y),
          landmarkPaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant PosePainter oldDelegate) {
    return oldDelegate.imageSize != imageSize || oldDelegate.poses != poses;
  }
}
