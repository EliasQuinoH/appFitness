import 'package:flutter/material.dart';
import '../../services/rutina_service.dart';
import '../../data/remote/models/rutina_model.dart';
import '../../widgets/loading_widget.dart';

class RutinasOnlinePage extends StatefulWidget {
  const RutinasOnlinePage({super.key});

  @override
  State<RutinasOnlinePage> createState() => _RutinasOnlinePageState();
}

class _RutinasOnlinePageState extends State<RutinasOnlinePage> {
  final RutinaService _rutinaService = RutinaService();

  List<RutinaModel> _rutinas = [];
  List<RutinaModel> _rutinasFiltradas = [];
  bool _isLoading = true;
  String _filterDificultad = 'Todos';
  String _filterTipo = 'Todos';

  final List<String> _dificultades = [
    'Todos',
    'principiante',
    'intermedio',
    'avanzado',
    'experto',
  ];

  final List<String> _tiposEjercicio = [
    'Todos',
    'fuerza',
    'cardio',
    'flexibilidad',
    'mixto',
    'completo',
  ];

  @override
  void initState() {
    super.initState();
    _cargarRutinas();
  }

  Future<void> _cargarRutinas() async {
    setState(() => _isLoading = true);

    try {
      final rutinas = await _rutinaService.getRutinas();

      setState(() {
        _rutinas = rutinas;
        _rutinasFiltradas = rutinas;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error cargando rutinas: $e')));
    }
  }

  void _filtrarRutinas() {
    setState(() {
      _rutinasFiltradas = _rutinas.where((rutina) {
        final cumpleDificultad =
            _filterDificultad == 'Todos' ||
            rutina.nivelDificultad == _filterDificultad;
        final cumpleTipo =
            _filterTipo == 'Todos' || rutina.tipoEjercicio == _filterTipo;
        return cumpleDificultad && cumpleTipo;
      }).toList();
    });
  }

  Future<void> _asignarRutina(int rutinaId) async {
    final success = await _rutinaService.asignarRutinaAMi(rutinaId);

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Rutina asignada exitosamente')),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Error al asignar rutina')));
    }
  }

  void _mostrarDetalleRutina(RutinaModel rutina) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text(rutina.nombre, style: const TextStyle(color: Colors.white)),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (rutina.descripcion != null && rutina.descripcion!.isNotEmpty)
                Text(
                  rutina.descripcion!,
                  style: const TextStyle(color: Colors.white70),
                ),

              const SizedBox(height: 10),

              Row(
                children: [
                  _infoChip('${rutina.nivelDificultad}', Colors.purpleAccent),
                  const SizedBox(width: 5),
                  _infoChip('${rutina.tipoEjercicio}', Colors.cyan),
                ],
              ),

              const SizedBox(height: 10),

              Text(
                'Duración: ${rutina.duracionMinutos} minutos',
                style: const TextStyle(color: Colors.white),
              ),

              Text(
                'Calorías estimadas: ${rutina.caloriasEstimadas}',
                style: const TextStyle(color: Colors.white),
              ),

              const SizedBox(height: 15),

              FutureBuilder<List<EjercicioEnRutina>>(
                future: _rutinaService.getEjerciciosDeRutina(rutina.id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError ||
                      !snapshot.hasData ||
                      snapshot.data!.isEmpty) {
                    return const Text(
                      'No hay ejercicios en esta rutina',
                      style: TextStyle(color: Colors.white70),
                    );
                  }

                  final ejercicios = snapshot.data!;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Ejercicios:',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ...ejercicios
                          .map(
                            (ejercicio) => ListTile(
                              leading: const Icon(
                                Icons.play_arrow,
                                color: Colors.purpleAccent,
                                size: 20,
                              ),
                              title: Text(
                                ejercicio.ejercicio.nombre,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                              subtitle: Text(
                                '${ejercicio.series} × ${ejercicio.repeticiones}',
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ],
                  );
                },
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
          ElevatedButton(
            onPressed: () {
              _asignarRutina(rutina.id);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purpleAccent,
            ),
            child: const Text('Asignar a mí'),
          ),
        ],
      ),
    );
  }

  Widget _infoChip(String text, Color color) {
    return Chip(
      label: Text(
        text,
        style: const TextStyle(fontSize: 12, color: Colors.white),
      ),
      backgroundColor: color.withOpacity(0.3),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Rutinas Online'),
        backgroundColor: Colors.purple[900],
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _cargarRutinas,
          ),
        ],
      ),
      body: _isLoading
          ? const LoadingWidget(message: 'Cargando rutinas...')
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
                          value: _filterDificultad,
                          dropdownColor: Colors.grey[900],
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            labelText: 'Dificultad',
                            labelStyle: TextStyle(color: Colors.purpleAccent),
                            border: OutlineInputBorder(),
                          ),
                          items: _dificultades.map((dificultad) {
                            return DropdownMenuItem(
                              value: dificultad,
                              child: Text(
                                dificultad == 'Todos'
                                    ? dificultad
                                    : dificultad.toUpperCase(),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() => _filterDificultad = value!);
                            _filtrarRutinas();
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
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
                            _filtrarRutinas();
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
                    '${_rutinasFiltradas.length} rutinas encontradas',
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),

                // Lista de rutinas
                Expanded(
                  child: _rutinasFiltradas.isEmpty
                      ? const Center(
                          child: Text(
                            'No se encontraron rutinas',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(10),
                          itemCount: _rutinasFiltradas.length,
                          itemBuilder: (context, index) {
                            final rutina = _rutinasFiltradas[index];
                            return Card(
                              color: Colors.grey[900],
                              margin: const EdgeInsets.only(bottom: 10),
                              child: ListTile(
                                leading: const CircleAvatar(
                                  backgroundColor: Colors.purple,
                                  child: Icon(
                                    Icons.list_alt,
                                    color: Colors.white,
                                  ),
                                ),
                                title: Text(
                                  rutina.nombre,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${rutina.nivelDificultad} • ${rutina.tipoEjercicio}',
                                      style: const TextStyle(
                                        color: Colors.white70,
                                      ),
                                    ),
                                    Text(
                                      '${rutina.duracionMinutos} min • ${rutina.caloriasEstimadas} cal',
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                trailing: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.purpleAccent,
                                ),
                                onTap: () => _mostrarDetalleRutina(rutina),
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
