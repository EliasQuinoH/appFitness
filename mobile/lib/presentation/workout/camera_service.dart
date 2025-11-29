// lib/presentation/workout/camera_service.dart
import 'dart:io';
import 'dart:ui';

import 'package:camera/camera.dart';
//import 'package:flutter/foundation.dart';

class CameraService {
  CameraController? _controller;
  CameraController? get controller => _controller;

  CameraDescription? _cameraDescription;

  /// Inicializa la cámara (frontal o trasera)
  Future<void> initializeCamera({
    CameraLensDirection preferredDirection = CameraLensDirection.front,
    ResolutionPreset resolution = ResolutionPreset.high,
  }) async {
    final cameras = await availableCameras();

    _cameraDescription = cameras.firstWhere(
      (camera) => camera.lensDirection == preferredDirection,
      orElse: () => cameras.first,
    );

    _controller = CameraController(
      _cameraDescription!,
      resolution,
      enableAudio: false,
      imageFormatGroup: Platform.isAndroid
          ? ImageFormatGroup.nv21
          : ImageFormatGroup.bgra8888,
    );

    await _controller!.initialize();
  }

  /// Inicia el stream de imágenes de la cámara
  void startImageStream(void Function(CameraImage image) onAvailable) {
    if (_controller != null && !_controller!.value.isStreamingImages) {
      _controller!.startImageStream(onAvailable);
    }
  }

  /// Detiene el stream de imágenes
  Future<void> stopImageStream() async {
    if (_controller != null && _controller!.value.isStreamingImages) {
      await _controller!.stopImageStream();
    }
  }

  /// Devuelve el tamaño de preview de la cámara
  Size get previewSize {
    final size = _controller!.value.previewSize!;
    // Nota: en Flutter, el previewSize viene como (width, height) según la cámara
    return Size(size.height, size.width); // swap si es necesario
  }

  void dispose() {
    _controller?.dispose();
  }
}
