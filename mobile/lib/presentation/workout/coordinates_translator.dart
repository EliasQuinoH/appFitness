//mobile\lib\presentation\workout\coordinates_translator.dart

//import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
// coordinates_translator.dart
// Este archivo contiene funciones para traducir las coordenadas
// del modelo de ML Kit (basadas en la imagen de la cámara)
// a coordenadas del canvas de Flutter, considerando rotación y cámara.

import 'dart:io';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:google_mlkit_commons/google_mlkit_commons.dart';

/// Traduce la coordenada X de la imagen a la coordenada X del canvas
double translateX(
  double x,
  Size canvasSize,
  Size imageSize,
  InputImageRotation rotation,
  CameraLensDirection cameraLensDirection,
) {
  switch (rotation) {
    case InputImageRotation.rotation90deg:
      // Rotación 90 grados (portrait invertido)
      return x *
          canvasSize.width /
          (Platform.isIOS ? imageSize.width : imageSize.height);
    case InputImageRotation.rotation270deg:
      // Rotación 270 grados
      return canvasSize.width -
          x *
              canvasSize.width /
              (Platform.isIOS ? imageSize.width : imageSize.height);
    case InputImageRotation.rotation0deg:
    case InputImageRotation.rotation180deg:
      // Rotación normal o 180 grados (landscape)
      switch (cameraLensDirection) {
        case CameraLensDirection.back:
        case CameraLensDirection.external:
          return x * canvasSize.width / imageSize.width;
        case CameraLensDirection.front:
          // Espejado en cámara frontal
          return canvasSize.width - x * canvasSize.width / imageSize.width;
      }
  }
}

/// Traduce la coordenada Y de la imagen a la coordenada Y del canvas
double translateY(
  double y,
  Size canvasSize,
  Size imageSize,
  InputImageRotation rotation,
  CameraLensDirection cameraLensDirection,
) {
  switch (rotation) {
    case InputImageRotation.rotation90deg:
    case InputImageRotation.rotation270deg:
      // Para rotaciones de 90 y 270, intercambiamos ancho y alto
      return y *
          canvasSize.height /
          (Platform.isIOS ? imageSize.height : imageSize.width);
    case InputImageRotation.rotation0deg:
    case InputImageRotation.rotation180deg:
      // Rotación normal o 180 grados
      return y * canvasSize.height / imageSize.height;
  }
}
