//mobile\lib\presentation\estadistica\StatisticsPage.dart

import 'package:flutter/material.dart';
//import '../../data/local/database.dart'; // Para acceder a la base de datos
import '../../main.dart';
//import '../../data/local/tables/user_profile_table.dart'; // Para las tablas de usuario

class StatisticsPage extends StatelessWidget {
  final int userId; // Recibir el userId

  const StatisticsPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Estadísticas")),
      body: FutureBuilder(
        future: _fetchAllData(), // Llamamos a la función que obtiene los datos
        builder: (context, AsyncSnapshot<Map<String, List<dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No hay datos disponibles"));
          }

          // Desplegar los datos de todas las tablas
          final data = snapshot.data!;
          return ListView(
            children: data.entries.map((entry) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      entry.key,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ...entry.value.map(
                    (item) => ListTile(title: Text(item.toString())),
                  ),
                ],
              );
            }).toList(),
          );
        },
      ),
    );
  }

  // Función para obtener todos los datos de las tablas
  Future<Map<String, List<dynamic>>> _fetchAllData() async {
    final db = appDatabase;
    final Map<String, List<dynamic>> allData = {};

    // Consultar datos del usuario por ID
    final user = await db.userDao.getUserById(
      userId,
    ); // Obtener el usuario usando el userId

    if (user != null) {
      // Consultar datos de la tabla de ejercicios
      final exercises = await db.exerciseDao.getAllExercises();
      allData['Ejercicios'] = exercises;

      // Consultar datos de la tabla de perfiles de usuario
      final profile = await db.userProfileDao.getProfileByUser(userId);
      allData['Perfil de Usuario'] = [
        profile,
      ]; // Asumiendo que hay solo un perfil por usuario

      // Aquí puedes agregar más consultas de tablas relacionadas al usuario si las tienes
    }

    return allData;
  }
}
