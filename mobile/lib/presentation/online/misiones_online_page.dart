import 'package:flutter/material.dart';
import '../../services/mision_service.dart';
import '../../widgets/loading_widget.dart';

class MisionesOnlinePage extends StatefulWidget {
  const MisionesOnlinePage({super.key});

  @override
  State<MisionesOnlinePage> createState() => _MisionesOnlinePageState();
}

class _MisionesOnlinePageState extends State<MisionesOnlinePage> {
  final MisionService _misionService = MisionService();

  List<MisionModel> _misionesDisponibles = [];
  List<ProgresoMisionModel> _misMisiones = [];
  List<ProgresoMisionModel> _misionesActivas = [];
  List<ProgresoMisionModel> _misionesCompletadas = [];

  bool _isLoading = true;
  int _selectedTab = 0; // 0: Disponibles, 1: Activas, 2: Completadas

  @override
  void initState() {
    super.initState();
    _cargarMisiones();
  }

  /*Future<void> _cargarMisiones() async {
    setState(() => _isLoading = true);
    
    try {
      final [
        disponibles,
        misMisiones,
        activas,
        completadas,
      ] = await Future.wait([
        _misionService.getMisionesDisponibles(),
        _misionService.getMisMisiones(),
        _misionService.getMisionesActivas(),
        _misionService.getMisionesCompletadas(),
      ]);
      
      setState(() {
        _misionesDisponibles = disponibles;
        _misMisiones = misMisiones;
        _misionesActivas = activas;
        _misionesCompletadas = completadas;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (!mounted) return;
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error cargando misiones: $e')),
      );
    }
  }*/

  Future<void> _cargarMisiones() async {
    setState(() => _isLoading = true);

    try {
      // Especificar los tipos para Future.wait
      final resultados = await Future.wait([
        _misionService.getMisionesDisponibles(),
        _misionService.getMisMisiones(),
        _misionService.getMisionesActivas(),
        _misionService.getMisionesCompletadas(),
      ]);

      // Casting explícito de los resultados
      final disponibles = resultados[0] as List<MisionModel>;
      final misMisiones = resultados[1] as List<ProgresoMisionModel>;
      final activas = resultados[2] as List<ProgresoMisionModel>;
      final completadas = resultados[3] as List<ProgresoMisionModel>;

      setState(() {
        _misionesDisponibles = disponibles;
        _misMisiones = misMisiones;
        _misionesActivas = activas;
        _misionesCompletadas = completadas;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error cargando misiones: $e')));
    }
  }

  Future<void> _aceptarMision(MisionModel mision) async {
    // TODO: Implementar aceptar misión
    // Necesitaríamos un endpoint para aceptar misiones
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Aceptaste la misión: ${mision.titulo}')),
    );
  }

  Future<void> _actualizarProgreso(int progresoId) async {
    final success = await _misionService.actualizarProgresoMision(
      progresoId,
      1,
    );

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Progreso actualizado')));
      _cargarMisiones(); // Recargar datos
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al actualizar progreso')),
      );
    }
  }

  Widget _buildMisionDisponibleCard(MisionModel mision) {
    return Card(
      color: Colors.grey[900],
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    mision.titulo,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                _dificultadChip(mision.dificultad),
              ],
            ),

            const SizedBox(height: 8),

            Text(
              mision.descripcion,
              style: const TextStyle(color: Colors.white70),
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                _infoChip('${mision.tipoMision}', Colors.purpleAccent),
                const SizedBox(width: 8),
                _infoChip(
                  '${mision.objetivo} ${_getUnidadDisplay(mision.unidadObjetivo)}',
                  Colors.cyan,
                ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.yellow, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          '${mision.recompensaXp} XP',
                          style: const TextStyle(color: Colors.yellow),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.diamond, color: Colors.cyan, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          '${mision.recompensaCristales} cristales',
                          style: const TextStyle(color: Colors.cyan),
                        ),
                      ],
                    ),
                  ],
                ),

                ElevatedButton(
                  onPressed: () => _aceptarMision(mision),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purpleAccent,
                  ),
                  child: const Text('Aceptar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgresoMisionCard(ProgresoMisionModel progreso) {
    final porcentaje = progreso.porcentajeCompletado;

    return Card(
      color: progreso.completada ? Colors.green[900] : Colors.grey[900],
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    progreso.misionTitulo,
                    style: TextStyle(
                      color: progreso.completada
                          ? Colors.green[300]
                          : Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (progreso.completada)
                  const Icon(Icons.check_circle, color: Colors.green, size: 24),
              ],
            ),

            const SizedBox(height: 12),

            // Barra de progreso
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Progreso: ${progreso.progresoActual}/${progreso.misionObjetivo}',
                      style: const TextStyle(color: Colors.white70),
                    ),
                    Text(
                      '$porcentaje%',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: porcentaje / 100,
                  backgroundColor: Colors.grey[800],
                  valueColor: AlwaysStoppedAnimation<Color>(
                    progreso.completada ? Colors.green : Colors.purpleAccent,
                  ),
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(4),
                ),
              ],
            ),

            const SizedBox(height: 12),

            if (!progreso.completada)
              Center(
                child: ElevatedButton(
                  onPressed: () => _actualizarProgreso(progreso.id),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purpleAccent,
                  ),
                  child: const Text('+1 Progreso'),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _dificultadChip(String dificultad) {
    Color color;
    switch (dificultad) {
      case 'facil':
        color = Colors.green;
        break;
      case 'medio':
        color = Colors.orange;
        break;
      case 'dificil':
        color = Colors.red;
        break;
      default:
        color = Colors.grey;
    }

    return Chip(
      label: Text(
        dificultad.toUpperCase(),
        style: const TextStyle(fontSize: 12, color: Colors.white),
      ),
      backgroundColor: color.withOpacity(0.3),
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

  String _getUnidadDisplay(String unidad) {
    switch (unidad) {
      case 'repeticiones':
        return 'repeticiones';
      case 'series':
        return 'series';
      case 'minutos':
        return 'minutos';
      case 'dias':
        return 'días';
      case 'rutinas':
        return 'rutinas';
      case 'ejercicios':
        return 'ejercicios';
      case 'veces':
        return 'veces';
      default:
        return unidad;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Misiones Online'),
        backgroundColor: Colors.purple[900],
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _cargarMisiones,
          ),
        ],
      ),
      body: _isLoading
          ? const LoadingWidget(message: 'Cargando misiones...')
          : Column(
              children: [
                // Tabs
                Container(
                  color: Colors.grey[900],
                  child: Row(
                    children: [
                      _buildTabButton(
                        0,
                        'Disponibles',
                        _misionesDisponibles.length,
                      ),
                      _buildTabButton(
                        1,
                        'En Progreso',
                        _misionesActivas.length,
                      ),
                      _buildTabButton(
                        2,
                        'Completadas',
                        _misionesCompletadas.length,
                      ),
                    ],
                  ),
                ),

                // Contador
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    _selectedTab == 0
                        ? '${_misionesDisponibles.length} misiones disponibles'
                        : _selectedTab == 1
                        ? '${_misionesActivas.length} misiones en progreso'
                        : '${_misionesCompletadas.length} misiones completadas',
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),

                // Lista de misiones
                Expanded(
                  child: _selectedTab == 0
                      ? _misionesDisponibles.isEmpty
                            ? const Center(
                                child: Text(
                                  'No hay misiones disponibles',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              )
                            : ListView.builder(
                                padding: const EdgeInsets.all(10),
                                itemCount: _misionesDisponibles.length,
                                itemBuilder: (context, index) =>
                                    _buildMisionDisponibleCard(
                                      _misionesDisponibles[index],
                                    ),
                              )
                      : _selectedTab == 1
                      ? _misionesActivas.isEmpty
                            ? const Center(
                                child: Text(
                                  'No tienes misiones en progreso',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              )
                            : ListView.builder(
                                padding: const EdgeInsets.all(10),
                                itemCount: _misionesActivas.length,
                                itemBuilder: (context, index) =>
                                    _buildProgresoMisionCard(
                                      _misionesActivas[index],
                                    ),
                              )
                      : _misionesCompletadas.isEmpty
                      ? const Center(
                          child: Text(
                            'No has completado misiones',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(10),
                          itemCount: _misionesCompletadas.length,
                          itemBuilder: (context, index) =>
                              _buildProgresoMisionCard(
                                _misionesCompletadas[index],
                              ),
                        ),
                ),
              ],
            ),
    );
  }

  Widget _buildTabButton(int index, String title, int count) {
    final isSelected = _selectedTab == index;

    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _selectedTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? Colors.purple[800] : Colors.transparent,
            border: isSelected
                ? const Border(
                    bottom: BorderSide(color: Colors.purpleAccent, width: 3),
                  )
                : null,
          ),
          child: Column(
            children: [
              Text(
                title,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.white70,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.purpleAccent : Colors.grey[700],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  count.toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
