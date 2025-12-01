/*// lib/presentacion/online/workout_online_page.dart
import 'package:flutter/material.dart';
import '../workout/mlkit_camera_page.dart';
import '../../services/ia_service.dart';
import '../../services/ejercicio_service.dart';
import '../../data/remote/models/ejercicio_model.dart';
import '../../widgets/loading_widget.dart';
import '../online/mlkit_online_page.dart';

class WorkoutOnlinePage extends StatefulWidget {
  const WorkoutOnlinePage({super.key});

  @override
  State<WorkoutOnlinePage> createState() => _WorkoutOnlinePageState();
}

class _WorkoutOnlinePageState extends State<WorkoutOnlinePage> {
  final EjercicioService _ejercicioService = EjercicioService();
  final IAService _iaService = IAService();
  
  List<EjercicioModel> _ejercicios = [];
  EjercicioModel? _ejercicioSeleccionado;
  bool _isLoading = true;
  bool _isEjercitando = false;

  @override
  void initState() {
    super.initState();
    _cargarEjercicios();
  }

  Future<void> _cargarEjercicios() async {
    setState(() => _isLoading = true);
    
    try {
      final ejercicios = await _ejercicioService.getEjercicios();
      
      setState(() {
        _ejercicios = ejercicios;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (!mounted) return;
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error cargando ejercicios: $e')),
      );
    }
  }

  void _iniciarEjercicio(EjercicioModel ejercicio) {
    Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => MlKitOnlinePage(
        ejercicio: ejercicio.nombre,
        ejercicioId: ejercicio.id,
        tipoEjercicio: ejercicio.tipo,
      ),
    ),
  );
}

  Future<void> _enviarResultadosAlBackend(Map<String, dynamic> datosDeteccion) async {
    // TODO: Implementar envío real al backend
    // Esto es un placeholder - necesitaríamos adaptar los datos de MLKit
    // para que coincidan con la estructura del backend
    
    final request = IAService.DeteccionPosturaRequest(
      ejercicio: _ejercicioSeleccionado!.id,
      modeloIa: 1, // ID del modelo - necesitaríamos obtenerlo
      puntosCorporalesDetectados: datosDeteccion['landmarks'] ?? {},
      precisionDeteccion: datosDeteccion['confidence'] ?? 0.8,
      puntuacionTecnica: (datosDeteccion['score'] ?? 70).toInt(),
      duracionAnalisisSegundos: datosDeteccion['duration'] ?? 10.0,
    );

    final respuesta = await _iaService.enviarDeteccion(request);
    
    if (!mounted) return;
    
    if (respuesta != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('¡Ejercicio enviado! +${respuesta.recompensaPuntos} puntos'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error enviando resultados'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _finalizarEjercicio() {
    setState(() {
      _isEjercitando = false;
      _ejercicioSeleccionado = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const LoadingWidget(message: 'Cargando ejercicios...');
    }

    if (_isEjercitando && _ejercicioSeleccionado != null) {
      // Usar la página de cámara existente pero adaptada
      return MlKitCameraPage(
        ejercicio: _ejercicioSeleccionado!,
        onFinish: (resultados) async {
          await _enviarResultadosAlBackend(resultados);
          _finalizarEjercicio();
        },
        onCancel: _finalizarEjercicio,
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Entrenamiento Online'),
        backgroundColor: Colors.purple[900],
      ),
      body: Column(
        children: [
          // Encabezado
          Container(
            padding: const EdgeInsets.all(20),
            color: Colors.purple[900]!.withOpacity(0.3),
            child: const Column(
              children: [
                Text(
                  'SELECCIONA UN EJERCICIO',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Usa la cámara para analizar tu técnica',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          // Lista de ejercicios
          Expanded(
            child: _ejercicios.isEmpty
                ? const Center(
                    child: Text(
                      'No hay ejercicios disponibles',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: _ejercicios.length,
                    itemBuilder: (context, index) {
                      final ejercicio = _ejercicios[index];
                      return Card(
                        color: Colors.grey[900],
                        margin: const EdgeInsets.only(bottom: 10),
                        child: ListTile(
                          leading: ejercicio.imagenUrl != null
                              ? CircleAvatar(
                                  backgroundImage: NetworkImage(ejercicio.imagenUrl!),
                                  backgroundColor: Colors.transparent,
                                )
                              : const CircleAvatar(
                                  backgroundColor: Colors.purple,
                                  child: Icon(Icons.fitness_center, color: Colors.white),
                                ),
                          title: Text(
                            ejercicio.nombre,
                            style: const TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            '${ejercicio.tipoDisplay} • ${ejercicio.grupoMuscularDisplay ?? "General"}',
                            style: const TextStyle(color: Colors.white70),
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios, color: Colors.purpleAccent),
                          onTap: () => _iniciarEjercicio(ejercicio),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
*/

// Eliminar completamente este archivo y reemplazarlo por:

import 'package:flutter/material.dart';
import '../../services/ejercicio_service.dart';
import '../../data/remote/models/ejercicio_model.dart';
import '../../widgets/loading_widget.dart';
import 'mlkit_online_page.dart'; // Importar la nueva página

class WorkoutOnlinePage extends StatefulWidget {
  const WorkoutOnlinePage({super.key});

  @override
  State<WorkoutOnlinePage> createState() => _WorkoutOnlinePageState();
}

class _WorkoutOnlinePageState extends State<WorkoutOnlinePage> {
  final EjercicioService _ejercicioService = EjercicioService();

  List<EjercicioModel> _ejercicios = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _cargarEjercicios();
  }

  Future<void> _cargarEjercicios() async {
    setState(() => _isLoading = true);

    try {
      final ejercicios = await _ejercicioService.getEjercicios();

      setState(() {
        _ejercicios = ejercicios;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error cargando ejercicios: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const LoadingWidget(message: 'Cargando ejercicios...');
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Entrenamiento Online'),
        backgroundColor: Colors.purple[900],
      ),
      body: Column(
        children: [
          // Encabezado
          Container(
            padding: const EdgeInsets.all(20),
            color: Colors.purple[900]!.withOpacity(0.3),
            child: const Column(
              children: [
                Text(
                  'SELECCIONA UN EJERCICIO',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Usa la cámara para analizar tu técnica',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),

          // Lista de ejercicios
          Expanded(
            child: _ejercicios.isEmpty
                ? const Center(
                    child: Text(
                      'No hay ejercicios disponibles',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: _ejercicios.length,
                    itemBuilder: (context, index) {
                      final ejercicio = _ejercicios[index];
                      return Card(
                        color: Colors.grey[900],
                        margin: const EdgeInsets.only(bottom: 10),
                        child: ListTile(
                          leading: ejercicio.imagenUrl != null
                              ? CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    ejercicio.imagenUrl!,
                                  ),
                                  backgroundColor: Colors.transparent,
                                )
                              : const CircleAvatar(
                                  backgroundColor: Colors.purple,
                                  child: Icon(
                                    Icons.fitness_center,
                                    color: Colors.white,
                                  ),
                                ),
                          title: Text(
                            ejercicio.nombre,
                            style: const TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            '${ejercicio.tipoDisplay} • ${ejercicio.grupoMuscularDisplay ?? "General"}',
                            style: const TextStyle(color: Colors.white70),
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.purpleAccent,
                          ),
                          onTap: () {
                            // Navegar directamente a MlKitOnlinePage
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => MlKitOnlinePage(
                                  ejercicio: ejercicio.nombre,
                                  ejercicioId: ejercicio.id,
                                  tipoEjercicio: ejercicio.tipo,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
