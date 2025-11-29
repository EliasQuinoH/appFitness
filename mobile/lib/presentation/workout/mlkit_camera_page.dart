import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'pose_detector_service.dart';
import 'camera_service.dart';
import 'pose_painter.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

class MLKitCameraPage extends StatefulWidget {
  final String exercise;

  const MLKitCameraPage({super.key, required this.exercise});

  @override
  State<MLKitCameraPage> createState() => _MLKitCameraPageState();
}

class _MLKitCameraPageState extends State<MLKitCameraPage> {
  late CameraService _cameraService;
  late PoseDetectorService _poseService;

  List<Pose> _poses = [];
  bool _isBusy = false;

  @override
  void initState() {
    super.initState();
    _cameraService = CameraService();
    _poseService = PoseDetectorService();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    await _cameraService.initializeCamera(
      preferredDirection: CameraLensDirection.front,
      resolution: ResolutionPreset.high,
    );

    _cameraService.startImageStream(_processCameraImage);

    if (mounted) setState(() {});
  }

  Future<void> _processCameraImage(CameraImage image) async {
    if (_isBusy) return;
    _isBusy = true;

    final controller = _cameraService.controller!;
    final poses = await _poseService.processCameraImage(
      image,
      controller.description.lensDirection,
      controller.description.sensorOrientation,
      controller.value.deviceOrientation,
    );

    if (mounted) {
      setState(() {
        _poses = poses;
      });
    }

    _isBusy = false;
  }

  @override
  void dispose() {
    _cameraService.dispose();
    _poseService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = _cameraService.controller;
    if (controller == null || !controller.value.isInitialized) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final previewSize = _cameraService.previewSize;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: CameraPreview(controller)),
          //CameraPreview(controller),
          CustomPaint(
            painter: PosePainter(
              _poses,
              previewSize,
              InputImageRotation
                  .rotation0deg, // la rotación ya se maneja en PoseDetectorService
              controller.description.lensDirection,
            ),
            child: Container(),
          ),
          Positioned(
            top: 50,
            left: 20,
            child: Text(
              "Ejercicio: ${widget.exercise}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
                shadows: [Shadow(blurRadius: 6, color: Colors.black)],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
