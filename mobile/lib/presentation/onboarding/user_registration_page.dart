// lib/presentation/onboarding/user_registration_page.dart
import 'package:flutter/material.dart';
import 'package:drift/drift.dart' show Value;
import '../../data/local/database.dart';
//import '../../data/local/tables/user_table.dart';
import '../home/home_page.dart';
import '../../main.dart'; // para usar appDatabase

class UserRegistrationPage extends StatefulWidget {
  const UserRegistrationPage({super.key});

  @override
  State<UserRegistrationPage> createState() => _UserRegistrationPageState();
}

class _UserRegistrationPageState extends State<UserRegistrationPage> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  late final AppDatabase _db;

  @override
  void initState() {
    super.initState();
    //_db = AppDatabase();
    _db = appDatabase;
  }

  Future<void> _registerUser() async {
    final email = emailController.text.trim();
    final name = nameController.text.trim();

    if (email.isEmpty || name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Completa todos los campos")),
      );
      return;
    }
    // Insertar usuario en la base de datos
    await _db.userDao.insertUser(
      UsersTableCompanion(
        email: Value(email),
        gameName: Value(name),
        level: const Value(1),
        experiencePoints: const Value(0),
        totalWorkouts: const Value(0),
        syncStatus: const Value(1), // marcado como pendiente de sincronizar
        lastModified: Value(DateTime.now()),
        //isActive: const Value(true), // <-- ACTIVAR DESDE EL INICIO
      ),
    );

    // Recuperar usuario recién creado
    final newUser = await _db.userDao.getUserByEmail(email);
    //if (!mounted) return; // <--- evita el warning
    if (!mounted || newUser == null) return;
    // Desactivar otros usuarios y activar este
    await _db.userDao.setActiveUser(newUser.id);
    // Navegar al HomePage pasando el usuario
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => HomePage(user: newUser)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.purple.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.purpleAccent, width: 2),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "REGISTRO DE JUGADOR",
                style: TextStyle(
                  color: Colors.purpleAccent,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              TextField(
                controller: emailController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: "Correo",
                  labelStyle: TextStyle(color: Colors.purpleAccent),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purpleAccent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              TextField(
                controller: nameController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: "Nombre del jugador",
                  labelStyle: TextStyle(color: Colors.purpleAccent),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purpleAccent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: _registerUser,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purpleAccent,
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 40,
                  ),
                ),
                child: const Text(
                  "ENTRAR AL JUEGO",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
