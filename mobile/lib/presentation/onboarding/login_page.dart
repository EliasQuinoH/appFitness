//mobile\lib\presentation\onboarding\login_page.dart
import 'package:flutter/material.dart';
import '../../main.dart'; // para usar appDatabase
import '../home/home_page.dart';
import '../../data/local/database.dart';
//import '../onboarding/user_registration_page.dart';
import '../splash/splash_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  late final AppDatabase _db;

  @override
  void initState() {
    super.initState();
    _db = appDatabase; // usar instancia global
  }

  Future<void> _login() async {
    final email = emailController.text.trim();
    if (email.isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Ingresa tu correo")));
      return;
    }

    final user = await _db.userDao.getUserByEmail(email);

    if (!mounted) return;

    if (user == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Usuario no encontrado")));
      return;
    }

    //  Marcar como usuario activo

    //final updated = user.copyWith(lastModified: DateTime.now());
    //await _db.userDao.updateUser(updated);
    // 🔥 Marcar como usuario activo
    await _db.userDao.setActiveUser(user.id);

    // Obtener  usuario actualizado (ya activo)
    final activeUser = await _db.userDao.getUserById(user.id);

    // 🔥 NAVIGAR AL HOME CON EL USUARIO
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => HomePage(user: activeUser!)),
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
            color: Colors.purple.withValues(alpha: 50),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.purpleAccent, width: 2),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "INICIAR SESIÓN",
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
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purpleAccent,
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 40,
                  ),
                ),
                child: const Text("ENTRAR", style: TextStyle(fontSize: 18)),
              ),
              const SizedBox(height: 15),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SplashPage()),
                  );
                },
                child: const Text(
                  "Crear cuenta",
                  style: TextStyle(
                    color: Colors.purpleAccent,
                    fontSize: 16,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
