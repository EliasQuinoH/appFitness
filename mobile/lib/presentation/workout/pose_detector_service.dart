// lib/presentation/workout/pose_detector_service.dart
import 'dart:io';
//import 'dart:ui';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
//import 'package:google_mlkit_commons/google_mlkit_commons.dart';

class PoseDetectorService {
  final PoseDetector _poseDetector = PoseDetector(
    options: PoseDetectorOptions(
      model: PoseDetectionModel.accurate, // <-- ACTIVA 3D
      mode: PoseDetectionMode.stream,
    ),
  );

  /// Convierte CameraImage a InputImage compatible con ML Kit
  InputImage? _inputImageFromCameraImage(
    CameraImage image,
    CameraLensDirection cameraLensDirection,
    int sensorOrientation,
    DeviceOrientation deviceOrientation,
  ) {
    // Mapeo de rotación según dispositivo
    final orientations = {
      DeviceOrientation.portraitUp: 0,
      DeviceOrientation.landscapeLeft: 90,
      DeviceOrientation.portraitDown: 180,
      DeviceOrientation.landscapeRight: 270,
    };

    int? rotationDegrees;
    if (Platform.isIOS) {
      rotationDegrees = sensorOrientation;
    } else {
      int? rotationCompensation = orientations[deviceOrientation];
      if (rotationCompensation == null) {
        return null;
      }

      rotationDegrees = cameraLensDirection == CameraLensDirection.front
          ? (sensorOrientation + rotationCompensation) % 360
          : (sensorOrientation - rotationCompensation + 360) % 360;
    }

    final rotation =
        InputImageRotationValue.fromRawValue(rotationDegrees) ??
        InputImageRotation.rotation0deg;

    // Validar formato de imagen
    final format = InputImageFormatValue.fromRawValue(image.format.raw);
    if (format == null ||
        (Platform.isAndroid && format != InputImageFormat.nv21) ||
        (Platform.isIOS && format != InputImageFormat.bgra8888))
      return null;

    // Solo se usa el primer plane
    if (image.planes.isEmpty) return null;
    final plane = image.planes.first;

    return InputImage.fromBytes(
      bytes: plane.bytes,
      metadata: InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: rotation,
        format: format,
        bytesPerRow: plane.bytesPerRow,
      ),
    );
  }

  /// Procesa la imagen de la cámara y devuelve la lista de poses
  Future<List<Pose>> processCameraImage(
    CameraImage image,
    CameraLensDirection cameraLensDirection,
    int sensorOrientation,
    DeviceOrientation deviceOrientation,
  ) async {
    final inputImage = _inputImageFromCameraImage(
      image,
      cameraLensDirection,
      sensorOrientation,
      deviceOrientation,
    );
    if (inputImage == null) return [];

    final poses = await _poseDetector.processImage(inputImage);
    return poses;
  }

  void dispose() {
    _poseDetector.close();
  }
}
