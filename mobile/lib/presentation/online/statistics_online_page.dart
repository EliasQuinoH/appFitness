// lib/presentacion/online/statistics_online_page.dart
import 'package:flutter/material.dart';
import '../../services/user_service.dart';
import '../../widgets/loading_widget.dart';

class StatisticsOnlinePage extends StatefulWidget {
  const StatisticsOnlinePage({super.key});

  @override
  State<StatisticsOnlinePage> createState() => _StatisticsOnlinePageState();
}

class _StatisticsOnlinePageState extends State<StatisticsOnlinePage> {
  final UserService _userService = UserService();

  Map<String, dynamic> _estadisticas = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _cargarEstadisticas();
  }

  Future<void> _cargarEstadisticas() async {
    setState(() => _isLoading = true);

    try {
      final estadisticas = await _userService.getEstadisticas();

      setState(() {
        _estadisticas = estadisticas;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error cargando estadísticas: $e')),
      );
    }
  }

  Widget _buildStatCard(
    String title,
    dynamic value,
    IconData icon,
    Color color,
  ) {
    return Card(
      color: Colors.grey[900],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 40),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(color: Colors.white70, fontSize: 14),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5),
            Text(
              value.toString(),
              style: TextStyle(
                color: color,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressCard(String title, int current, int max, Color color) {
    final porcentaje = max > 0 ? (current / max * 100).toInt() : 0;

    return Card(
      color: Colors.grey[900],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$current/$max',
                  style: const TextStyle(color: Colors.white70),
                ),
                Text(
                  '$porcentaje%',
                  style: TextStyle(color: color, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: max > 0 ? current / max : 0,
              backgroundColor: Colors.grey[800],
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 8,
              borderRadius: BorderRadius.circular(4),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityChart() {
    // Datos de ejemplo para gráfico de actividad semanal
    final Map<String, int> actividadSemanal = {
      'Lun': _estadisticas['lunes'] ?? 0,
      'Mar': _estadisticas['martes'] ?? 0,
      'Mié': _estadisticas['miercoles'] ?? 0,
      'Jue': _estadisticas['jueves'] ?? 0,
      'Vie': _estadisticas['viernes'] ?? 0,
      'Sáb': _estadisticas['sabado'] ?? 0,
      'Dom': _estadisticas['domingo'] ?? 0,
    };

    final maxValue = actividadSemanal.values.reduce((a, b) => a > b ? a : b);

    return Card(
      color: Colors.grey[900],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Actividad Semanal',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: 150,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: actividadSemanal.entries.map((entry) {
                  final height = maxValue > 0
                      ? (entry.value / maxValue * 100).toDouble()
                      : 0;

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        entry.value.toString(),
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        width: 30,
                        height: height.toDouble(),
                        decoration: BoxDecoration(
                          color: Colors.purpleAccent,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(4),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        entry.key,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAchievementCard(
    String title,
    String description,
    bool unlocked,
  ) {
    return Card(
      color: Colors.grey[900],
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Icon(
              unlocked ? Icons.check_circle : Icons.lock,
              color: unlocked ? Colors.green : Colors.grey,
              size: 30,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: unlocked ? Colors.white : Colors.white70,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Estadísticas Online'),
        backgroundColor: Colors.purple[900],
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _cargarEstadisticas,
          ),
        ],
      ),
      body: _isLoading
          ? const LoadingWidget(message: 'Cargando estadísticas...')
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Título
                  const Text(
                    'Mis Estadísticas',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Resumen de tu progreso en Hunter Fit',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Estadísticas principales en Grid
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.8,
                    children: [
                      _buildStatCard(
                        'Puntos Totales',
                        _estadisticas['total_puntos_experiencia'] ?? 0,
                        Icons.star,
                        Colors.yellow,
                      ),
                      _buildStatCard(
                        'Cristales',
                        _estadisticas['total_cristales'] ?? 0,
                        Icons.diamond,
                        Colors.cyan,
                      ),
                      _buildStatCard(
                        'Rutinas Completadas',
                        _estadisticas['rutinas_completadas'] ?? 0,
                        Icons.check_circle,
                        Colors.green,
                      ),
                      _buildStatCard(
                        'Misiones Completadas',
                        _estadisticas['misiones_completadas'] ?? 0,
                        Icons.flag,
                        Colors.orange,
                      ),
                      _buildStatCard(
                        'Ejercicios Realizados',
                        _estadisticas['ejercicios_realizados'] ?? 0,
                        Icons.fitness_center,
                        Colors.purpleAccent,
                      ),
                      _buildStatCard(
                        'Tiempo Entrenamiento',
                        '${_estadisticas['tiempo_total_entrenamiento'] ?? 0} min',
                        Icons.timer,
                        Colors.blue,
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Gráfico de actividad
                  _buildActivityChart(),

                  const SizedBox(height: 20),

                  // Progresos
                  const Text(
                    'Progresos',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),

                  _buildProgressCard(
                    'Promedio Puntuación Técnica',
                    (_estadisticas['promedio_puntuacion_tecnica'] ?? 0).toInt(),
                    100,
                    Colors.purpleAccent,
                  ),

                  const SizedBox(height: 10),

                  _buildProgressCard(
                    'Cartas Coleccionadas',
                    _estadisticas['cartas_coleccionadas'] ?? 0,
                    50, // Objetivo total de ejemplo
                    Colors.cyan,
                  ),

                  const SizedBox(height: 10),

                  _buildProgressCard(
                    'Items Obtenidos',
                    _estadisticas['items_obtenidos'] ?? 0,
                    30, // Objetivo total de ejemplo
                    Colors.orange,
                  ),

                  const SizedBox(height: 20),

                  // Ranking
                  if (_estadisticas['posicion_ranking_global'] != null)
                    Card(
                      color: Colors.grey[900],
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Ranking Global',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(
                                  Icons.leaderboard,
                                  color: Colors.yellow[700],
                                  size: 40,
                                ),
                                const SizedBox(width: 15),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Posición #${_estadisticas['posicion_ranking_global']}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Text(
                                      'En el ranking global',
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                  const SizedBox(height: 20),

                  // Logros (ejemplo)
                  const Text(
                    'Logros Destacados',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),

                  _buildAchievementCard(
                    'Principiante',
                    'Completa tu primera rutina',
                    _estadisticas['rutinas_completadas'] != null &&
                        _estadisticas['rutinas_completadas']! > 0,
                  ),

                  const SizedBox(height: 8),

                  _buildAchievementCard(
                    'Coleccionista',
                    'Colecciona 10 cartas',
                    _estadisticas['cartas_coleccionadas'] != null &&
                        _estadisticas['cartas_coleccionadas']! >= 10,
                  ),

                  const SizedBox(height: 8),

                  _buildAchievementCard(
                    'Atleta Consistente',
                    'Entrena 7 días seguidos',
                    false, // Ejemplo bloqueado
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
    );
  }
}
