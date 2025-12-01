// lib/presentacion/online/mlkit_online_page.dart
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import '../../services/workout_service.dart';
import '../../utils/pose_analyzer.dart';
import '../workout/camera_service.dart';
import '../workout/pose_detector_service.dart';
import '../workout/pose_painter.dart';

class MlKitOnlinePage extends StatefulWidget {
  final String ejercicio;
  final int ejercicioId;
  final String tipoEjercicio;

  const MlKitOnlinePage({
    super.key,
    required this.ejercicio,
    required this.ejercicioId,
    required this.tipoEjercicio,
  });

  @override
  State<MlKitOnlinePage> createState() => _MlKitOnlinePageState();
}

class _MlKitOnlinePageState extends State<MlKitOnlinePage> {
  late CameraService _cameraService;
  late PoseDetectorService _poseService;
  final WorkoutService _workoutService = WorkoutService();

  List<Pose> _poses = [];
  bool _isBusy = false;
  bool _isAnalizando = false;
  int _repeticiones = 0;
  int _puntuacionTotal = 0;
  List<Map<String, dynamic>> _analisisLista = [];
  List<String> _correcciones = [];

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
    if (_isBusy || !_isAnalizando) return;
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

    // Analizar pose si hay detección
    if (poses.isNotEmpty && _isAnalizando) {
      await _analizarPose(poses);
    }

    _isBusy = false;
  }

  Future<void> _analizarPose(List<Pose> poses) async {
    Map<String, dynamic> analisis;

    // Seleccionar analizador según tipo de ejercicio
    switch (widget.tipoEjercicio.toLowerCase()) {
      case 'sentadilla':
        analisis = PoseAnalyzer.analizarSentadilla(poses);
        break;
      case 'flexiones':
        analisis = PoseAnalyzer.analizarFlexiones(poses);
        break;
      default:
        analisis = {'puntuacion': 80, 'precision': 0.7, 'correcciones': []};
    }

    if (analisis.containsKey('error')) {
      return;
    }

    // Si la puntuación es buena, contar como repetición
    if (analisis['puntuacion'] >= 70 && !_isBusy) {
      _repeticiones++;
      _puntuacionTotal += (analisis['puntuacion'] as num).toInt();

      // Guardar análisis para enviar al backend
      _analisisLista.add({
        'timestamp': DateTime.now().toIso8601String(),
        'puntos_corporales': PoseAnalyzer.poseToJson(poses.first),
        'puntuacion': analisis['puntuacion'],
        'precision': analisis['precision'],
      });

      // Agregar correcciones
      if (analisis['correcciones'] is List) {
        final nuevasCorrecciones = List<String>.from(analisis['correcciones']);
        for (final correccion in nuevasCorrecciones) {
          if (!_correcciones.contains(correccion)) {
            _correcciones.add(correccion);
          }
        }
      }

      if (mounted) setState(() {});
    }
  }

  Future<void> _enviarResultadosAlBackend() async {
    print('=== ENVIANDO AL BACKEND ===');
    print('Ejercicio ID: ${widget.ejercicioId}');
    print('Repeticiones: $_repeticiones');
    print('Puntuación promedio: ${(_puntuacionTotal / _repeticiones).round()}');
    print('Análisis en lista: ${_analisisLista.length}');
    if (_analisisLista.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No hay análisis para enviar'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    // Mostrar indicador de carga
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const AlertDialog(
        backgroundColor: Colors.transparent,
        content: Center(
          child: CircularProgressIndicator(color: Colors.purpleAccent),
        ),
      ),
    );

    try {
      final puntuacionPromedio = (_puntuacionTotal / _repeticiones).round();

      final analisis = AnalisisPostura(
        puntosCorporales: _analisisLista.last['puntos_corporales'],
        precision:
            _analisisLista.fold(0.0, (sum, a) => sum + a['precision']) /
            _analisisLista.length,
        puntuacion: puntuacionPromedio,
        ejercicio: widget.ejercicioId.toString(),
        repeticiones: _repeticiones,
      );

      final resultado = await _workoutService.enviarAnalisisPostura(analisis);

      // Cerrar diálogo de carga
      if (mounted) Navigator.pop(context);

      if (resultado['success'] == true) {
        // Mostrar éxito con detalles
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.grey[900],
            title: const Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green),
                SizedBox(width: 10),
                Text('¡Éxito!', style: TextStyle(color: Colors.white)),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Resultados enviados correctamente',
                  style: const TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 10),
                Text(
                  '• Repeticiones: $_repeticiones',
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  '• Puntuación promedio: $puntuacionPromedio',
                  style: const TextStyle(color: Colors.white),
                ),
                if (resultado['data'] != null &&
                    resultado['data']['recompensa_puntos'] != null)
                  Text(
                    '• Puntos ganados: ${resultado['data']['recompensa_puntos']}',
                    style: const TextStyle(
                      color: Colors.yellow,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Cerrar',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Cerrar diálogo
                  Navigator.pop(context); // Volver a lista de ejercicios
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purpleAccent,
                ),
                child: const Text('Continuar'),
              ),
            ],
          ),
        );
      } else {
        // Mostrar error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('❌ Error: ${resultado['error']}'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5),
          ),
        );
      }
    } catch (e) {
      if (mounted) Navigator.pop(context); // Cerrar diálogo de carga

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('❌ Error inesperado: $e'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 5),
        ),
      );
    }
  }

  void _toggleAnalisis() {
    setState(() {
      _isAnalizando = !_isAnalizando;
      if (!_isAnalizando && _repeticiones > 0) {
        _enviarResultadosAlBackend();
      }
    });
  }

  void _reiniciarSesion() {
    setState(() {
      _repeticiones = 0;
      _puntuacionTotal = 0;
      _analisisLista.clear();
      _correcciones.clear();
      _isAnalizando = false;
    });
  }

  @override
  void dispose() {
    _cameraService.dispose();
    _poseService.dispose();
    super.dispose();
  }

  // En lib/presentacion/online/mlkit_online_page.dart, actualizar el método build():

  @override
  Widget build(BuildContext context) {
    final controller = _cameraService.controller;
    if (controller == null || !controller.value.isInitialized) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: Colors.purpleAccent),
              SizedBox(height: 20),
              Text(
                'Inicializando cámara...',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      );
    }

    final previewSize = _cameraService.previewSize;
    final puntuacionPromedio = _repeticiones > 0
        ? (_puntuacionTotal / _repeticiones).round()
        : 0;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Vista de cámara
          Positioned.fill(child: CameraPreview(controller)),

          // Overlay de poses
          CustomPaint(
            painter: PosePainter(
              _poses,
              previewSize,
              InputImageRotation.rotation0deg,
              controller.description.lensDirection,
            ),
            child: Container(),
          ),

          // Overlay de información SUPERIOR
          Positioned(
            top: 40,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(16),
              color: Colors.black.withOpacity(0.7),
              child: Column(
                children: [
                  Text(
                    widget.ejercicio.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.purpleAccent,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Contadores principales
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildCounterCard(
                        'REPETICIONES',
                        '$_repeticiones',
                        Colors.purpleAccent,
                      ),
                      _buildCounterCard(
                        'PUNTUACIÓN',
                        '$puntuacionPromedio',
                        _getColorForScore(puntuacionPromedio),
                      ),
                      _buildCounterCard(
                        'ESTADO',
                        _isAnalizando ? 'ANALIZANDO' : 'PAUSA',
                        _isAnalizando ? Colors.green : Colors.orange,
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // Indicador de conexión
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.cloud_upload,
                        color: _analisisLista.isEmpty
                            ? Colors.grey
                            : Colors.cyan,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _analisisLista.isEmpty
                            ? 'Listo para analizar'
                            : '${_analisisLista.length} análisis listos',
                        style: TextStyle(
                          color: _analisisLista.isEmpty
                              ? Colors.grey
                              : Colors.cyan,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Correcciones (si hay)
          if (_correcciones.isNotEmpty)
            Positioned(
              top: 180,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.redAccent, width: 2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.warning, color: Colors.white, size: 20),
                        SizedBox(width: 8),
                        Text(
                          'CORRECCIONES',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ..._correcciones
                        .map(
                          (correccion) => Padding(
                            padding: const EdgeInsets.only(left: 8, bottom: 4),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.arrow_right,
                                  color: Colors.white,
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    correccion,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ],
                ),
              ),
            ),

          // Botones de control INFERIORES
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  // Barra de estado
                  if (_isAnalizando && _repeticiones > 0)
                    Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.green),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '✅ Repetición $_repeticiones detectada - Puntuación: $puntuacionPromedio',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                  // Botones
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Botón iniciar/pausar
                      _buildControlButton(
                        icon: _isAnalizando ? Icons.pause : Icons.play_arrow,
                        label: _isAnalizando ? 'PAUSAR' : 'INICIAR',
                        color: _isAnalizando ? Colors.red : Colors.green,
                        onPressed: _toggleAnalisis,
                      ),

                      // Botón reiniciar
                      _buildControlButton(
                        icon: Icons.refresh,
                        label: 'REINICIAR',
                        color: Colors.orange,
                        onPressed: _reiniciarSesion,
                      ),

                      // Botón finalizar/enviar
                      _buildControlButton(
                        icon: Icons.cloud_upload,
                        label: _repeticiones > 0 ? 'ENVIAR' : 'SALIR',
                        color: _repeticiones > 0 ? Colors.blue : Colors.grey,
                        onPressed: () async {
                          if (_repeticiones > 0) {
                            // Mostrar diálogo de confirmación
                            final confirmar = await showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                backgroundColor: Colors.grey[900],
                                title: const Text(
                                  'Enviar resultados',
                                  style: TextStyle(color: Colors.white),
                                ),
                                content: Text(
                                  '¿Enviar $_repeticiones repeticiones al servidor?',
                                  style: const TextStyle(color: Colors.white70),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, false),
                                    child: const Text(
                                      'Cancelar',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () =>
                                        Navigator.pop(context, true),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.purpleAccent,
                                    ),
                                    child: const Text('ENVIAR'),
                                  ),
                                ],
                              ),
                            );

                            if (confirmar == true) {
                              await _enviarResultadosAlBackend();
                            }
                          } else {
                            Navigator.pop(context);
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Método auxiliar para botones de control
  Widget _buildControlButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 2),
          ),
          child: IconButton(
            icon: Icon(icon, color: color, size: 30),
            onPressed: onPressed,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  // Método auxiliar para tarjetas de contador
  Widget _buildCounterCard(String title, String value, Color color) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: color, width: 2),
          ),
          child: Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  // Método para obtener color según puntuación
  Color _getColorForScore(int score) {
    if (score >= 90) return Colors.green;
    if (score >= 70) return Colors.yellow;
    if (score >= 50) return Colors.orange;
    return Colors.red;
  }

  Widget _buildInfoCard(String title, String value, Color color) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: color.withOpacity(0.3),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: color),
          ),
          child: Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
