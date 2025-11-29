// lib/presentation/onboarding/user_profile_form_page.dart
import 'package:flutter/material.dart';

import '../../data/local/database.dart';
import '../../main.dart'; // para usar appDatabase
//import 'package:drift/drift.dart'; // <- necesario para Value()
import 'package:drift/drift.dart' hide Column;
import '../onboarding/system_prompt_page.dart';
import '../../data/remote/geminis_api.dart';

class UserProfileFormPage extends StatefulWidget {
  const UserProfileFormPage({super.key});

  @override
  State<UserProfileFormPage> createState() => _UserProfileFormPageState();
}

class _UserProfileFormPageState extends State<UserProfileFormPage> {
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  final _ageController = TextEditingController();
  final _issuesController = TextEditingController();
  final _painsController = TextEditingController();

  late final AppDatabase _db;

  @override
  void initState() {
    super.initState();
    _db = appDatabase;
    // Sembrar ejercicios base al iniciar
    _db.exerciseDao.seedExercises();
  }

  @override
  void dispose() {
    _weightController.dispose();
    _heightController.dispose();
    _ageController.dispose();
    _issuesController.dispose();
    _painsController.dispose();
    super.dispose();
  }

  Future<void> _submitProfile() async {
    final weight = double.tryParse(_weightController.text.trim());
    final height = double.tryParse(_heightController.text.trim());
    final age = int.tryParse(_ageController.text.trim());
    final issues = _issuesController.text.trim();
    final pains = _painsController.text.trim();

    if (weight == null || height == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Peso y talla son obligatorios")),
      );
      return;
    }

    final activeUser = await _db.userDao.getActiveUser();
    if (activeUser == null) return;

    // Guardar perfil en la base de datos local
    await _db.userProfileDao.insertProfile(
      UserProfileTableCompanion(
        userId: Value(activeUser.id),
        weight: Value(weight),
        height: Value(height),
        age: Value(age),
        issues: Value(issues.isEmpty ? null : issues),
        pains: Value(pains.isEmpty ? null : pains),
      ),
    );

    // Traer todos los ejercicios disponibles
    final exercises = await _db.exerciseDao.getAllExercises();

    // Llamar a GeminiAPI para generar rutina
    final routineText = await GeminiAPI.generateRoutine(
      weight: weight,
      height: height,
      age: age,
      issues: issues.isEmpty ? null : issues,
      pains: pains.isEmpty ? null : pains,
      exercises: exercises, // Pasamos los ejercicios disponibles
    );

    if (!mounted) return;

    if (routineText != null) {
      print("Rutina generada: $routineText");
      // Guardar la rutina en UserRoutineTable
      final userRoutineId = await _db.userRoutineDao.insertUserRoutine(
        UserRoutineTableCompanion(
          userId: Value(activeUser.id),
          title: Value("Rutina Personalizada"),
          notes: Value(routineText),
        ),
      );
      // Parsear el texto de Gemini a ejercicios (ejemplo simple con comas)
      final lines = routineText.split("\n");
      for (var line in lines) {
        final parts = line.split(
          ",",
        ); // Suponemos formato: ejercicio,reps,duración
        if (parts.length >= 2) {
          final exerciseName = parts[0].trim();
          final exercise = exercises.firstWhere(
            (e) => e.name.toLowerCase() == exerciseName.toLowerCase(),
            orElse: () => exercises.first,
          );

          final reps = int.tryParse(parts[1].trim());
          final duration = parts.length > 2
              ? int.tryParse(parts[2].trim())
              : null;

          await _db.userRoutineExerciseDao.insertUserRoutineExercise(
            UserRoutineExerciseTableCompanion(
              userRoutineId: Value(userRoutineId),
              exerciseId: Value(exercise.id),
              reps: Value(reps),
              duration: Value(duration),
            ),
          );
        }
      }
    }

    // Navegar a SystemPromptPage
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const SystemPromptPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text("Perfil del Jugador")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Peso (kg)",
                labelStyle: TextStyle(color: Colors.purpleAccent),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _heightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Talla (cm)",
                labelStyle: TextStyle(color: Colors.purpleAccent),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Edad",
                labelStyle: TextStyle(color: Colors.purpleAccent),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _issuesController,
              decoration: const InputDecoration(
                labelText: "Enfermedades",
                labelStyle: TextStyle(color: Colors.purpleAccent),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _painsController,
              decoration: const InputDecoration(
                labelText: "Dolores / molestias",
                labelStyle: TextStyle(color: Colors.purpleAccent),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _submitProfile,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purpleAccent,
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 40,
                ),
              ),
              child: const Text("Guardar y Generar Rutina"),
            ),
          ],
        ),
      ),
    );
  }
}
