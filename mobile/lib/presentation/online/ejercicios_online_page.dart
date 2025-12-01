import 'package:flutter/material.dart';
import '../../services/ejercicio_service.dart';
import '../../data/remote/models/ejercicio_model.dart';
import '../../widgets/loading_widget.dart';

class EjerciciosOnlinePage extends StatefulWidget {
  const EjerciciosOnlinePage({super.key});

  @override
  State<EjerciciosOnlinePage> createState() => _EjerciciosOnlinePageState();
}

class _EjerciciosOnlinePageState extends State<EjerciciosOnlinePage> {
  final EjercicioService _ejercicioService = EjercicioService();

  List<EjercicioModel> _ejercicios = [];
  List<EjercicioModel> _ejerciciosFiltrados = [];
  bool _isLoading = true;
  String _filterTipo = 'Todos';
  String _filterGrupo = 'Todos';

  final List<String> _tiposEjercicio = [
    'Todos',
    'fuerza',
    'cardio',
    'flexibilidad',
    'equilibrio',
    'calentamiento',
  ];

  final List<String> _gruposMusculares = [
    'Todos',
    'pecho',
    'espalda',
    'hombros',
    'piernas',
    'brazos',
    'abdomen',
    'gluteos',
    'full_body',
    'cardiovascular',
  ];

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
        _ejerciciosFiltrados = ejercicios;
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

  void _filtrarEjercicios() {
    setState(() {
      _ejerciciosFiltrados = _ejercicios.where((ejercicio) {
        final cumpleTipo =
            _filterTipo == 'Todos' || ejercicio.tipo == _filterTipo;
        final cumpleGrupo =
            _filterGrupo == 'Todos' ||
            (ejercicio.grupoMuscular == _filterGrupo ||
                (ejercicio.grupoMuscular == null && _filterGrupo == 'Todos'));
        return cumpleTipo && cumpleGrupo;
      }).toList();
    });
  }

  void _mostrarDetalleEjercicio(EjercicioModel ejercicio) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text(
          ejercicio.nombre,
          style: const TextStyle(color: Colors.white),
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (ejercicio.imagenUrl != null &&
                  ejercicio.imagenUrl!.isNotEmpty)
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: NetworkImage(ejercicio.imagenUrl!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

              const SizedBox(height: 10),

              Text(
                'Tipo: ${ejercicio.tipo}',
                style: const TextStyle(color: Colors.purpleAccent),
              ),

              if (ejercicio.grupoMuscular != null)
                Text(
                  'Grupo muscular: ${ejercicio.grupoMuscular}',
                  style: const TextStyle(color: Colors.cyan),
                ),

              const SizedBox(height: 10),

              Text(
                'Duración: ${ejercicio.duracionEstimadaMinutos} min',
                style: const TextStyle(color: Colors.white70),
              ),

              Text(
                'Calorías/min: ${ejercicio.caloriasEstimadasPorMinuto.toStringAsFixed(1)}',
                style: const TextStyle(color: Colors.white70),
              ),

              const SizedBox(height: 15),

              if (ejercicio.descripcion != null &&
                  ejercicio.descripcion!.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Descripción:',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      ejercicio.descripcion!,
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                ),

              if (ejercicio.instrucciones != null &&
                  ejercicio.instrucciones!.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    const Text(
                      'Instrucciones:',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      ejercicio.instrucciones!,
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cerrar',
              style: TextStyle(color: Colors.purpleAccent),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Ejercicios Online'),
        backgroundColor: Colors.purple[900],
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _cargarEjercicios,
          ),
        ],
      ),
      body: _isLoading
          ? const LoadingWidget(message: 'Cargando ejercicios...')
          : Column(
              children: [
                // Filtros
                Container(
                  padding: const EdgeInsets.all(10),
                  color: Colors.grey[900],
                  child: Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _filterTipo,
                          dropdownColor: Colors.grey[900],
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            labelText: 'Tipo',
                            labelStyle: TextStyle(color: Colors.purpleAccent),
                            border: OutlineInputBorder(),
                          ),
                          items: _tiposEjercicio.map((tipo) {
                            return DropdownMenuItem(
                              value: tipo,
                              child: Text(
                                tipo == 'Todos' ? tipo : tipo.toUpperCase(),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() => _filterTipo = value!);
                            _filtrarEjercicios();
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _filterGrupo,
                          dropdownColor: Colors.grey[900],
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            labelText: 'Grupo',
                            labelStyle: TextStyle(color: Colors.purpleAccent),
                            border: OutlineInputBorder(),
                          ),
                          items: _gruposMusculares.map((grupo) {
                            return DropdownMenuItem(
                              value: grupo,
                              child: Text(
                                grupo == 'Todos' ? grupo : grupo.toUpperCase(),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() => _filterGrupo = value!);
                            _filtrarEjercicios();
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                // Contador
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    '${_ejerciciosFiltrados.length} ejercicios encontrados',
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),

                // Lista de ejercicios
                Expanded(
                  child: _ejerciciosFiltrados.isEmpty
                      ? const Center(
                          child: Text(
                            'No se encontraron ejercicios',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(10),
                          itemCount: _ejerciciosFiltrados.length,
                          itemBuilder: (context, index) {
                            final ejercicio = _ejerciciosFiltrados[index];
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
                                  '${ejercicio.tipo} • ${ejercicio.grupoMuscular ?? "General"}',
                                  style: const TextStyle(color: Colors.white70),
                                ),
                                trailing: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.purpleAccent,
                                ),
                                onTap: () =>
                                    _mostrarDetalleEjercicio(ejercicio),
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
