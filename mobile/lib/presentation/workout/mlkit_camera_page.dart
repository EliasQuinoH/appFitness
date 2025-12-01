//mobile\lib\presentation\workout\mlkit_camera_page.dart
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'pose_detector_service.dart';
import 'camera_service.dart';
import 'pose_painter.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

// Detectores de ejercicios
import 'detectors/pushup_detector.dart'; // detector de flexiones
import 'detectors/jumpingjack_detector.dart'; // detector de saltos tijera
import 'detectors/squat_detector.dart'; // detector de sentadillas
import 'detectors/abs_detector.dart'; // detector de abdominales
import 'detectors/plank_detector.dart'; // detector de plancha

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

  // Detector de flexiones
  //late PushUpDetector _pushUpDetector;
  //int _reps = 0;
  // Repeticiones
  int _reps = 0;

  // Detectores
  PushUpDetector? _pushUpDetector;
  JumpingJackDetector? _jumpingJackDetector;
  SquatDetector? _squatDetector;
  AbsDetector? _absDetector;
  //PlankDetector? _plankDetector;

  @override
  void initState() {
    super.initState();
    _cameraService = CameraService();
    _poseService = PoseDetectorService();

    // Inicializa el detector solo si es flexiones
    //if (widget.exercise.toLowerCase() == 'flexiones') {
    //  _pushUpDetector = PushUpDetector();
    //}
    // Inicializa el detector correspondiente
    switch (widget.exercise.toLowerCase()) {
      case 'flexiones':
        _pushUpDetector = PushUpDetector();
        break;
      case 'jumping jacks':
        _jumpingJackDetector = JumpingJackDetector();
        break;
      case 'sentadillas':
        _squatDetector = SquatDetector();
        break;
      case 'abdominales':
        _absDetector = AbsDetector();
        break;
    }

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

    // Detectar repeticiones solo para flexiones
    //if (widget.exercise.toLowerCase() == 'flexiones') {
    //  _pushUpDetector.detectPushUp(poses);
    //  _reps = _pushUpDetector.reps;
    //}

    // Detectar repeticiones según el ejercicio
    switch (widget.exercise.toLowerCase()) {
      case 'flexiones':
        _pushUpDetector?.detectPushUp(poses);
        _reps = _pushUpDetector?.reps ?? 0;
        break;
      case 'jumping jacks':
        _jumpingJackDetector?.detectJumpingJack(poses);
        _reps = _jumpingJackDetector?.reps ?? 0;
        break;
      case 'sentadillas':
        _squatDetector?.detectSquat(poses);
        _reps = _squatDetector?.reps ?? 0;
        break;
      case 'abdominales':
        _absDetector?.detectAbs(poses);
        _reps = _absDetector?.reps ?? 0;
        break;
    }

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
          /// Dibujo de puntos del cuerpo
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

          ///  Nombre del ejercicio
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
          // Contador de repeticiones
          Positioned(
              top: 100,
              left: 20,
              child: Text(
                "Reps: $_reps",
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 32,
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
