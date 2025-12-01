import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import '../../widgets/loading_widget.dart';
import 'login_online_page.dart';
//import 'home_online_page.dart';
//import '../../data/remote/models/user_model.dart';

class SplashOnlinePage extends StatefulWidget {
  const SplashOnlinePage({super.key});

  @override
  State<SplashOnlinePage> createState() => _SplashOnlinePageState();
}

class _SplashOnlinePageState extends State<SplashOnlinePage> {
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    await Future.delayed(const Duration(seconds: 2)); // Splash delay

    final isLoggedIn = await _authService.isLoggedIn();

    if (!mounted) return;

    if (isLoggedIn) {
      // Usuario logueado - ir al home online
      // Por ahora vamos directo al login online
      // TODO: Implementar obtención de datos del usuario logueado
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginOnlinePage()),
      );
    } else {
      // No logueado - ir al login online
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginOnlinePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo de la app
            Image.asset("assets/images/icono_app.png", width: 150, height: 150),
            const SizedBox(height: 20),
            const Text(
              "HUNTER FIT",
              style: TextStyle(
                color: Colors.purpleAccent,
                fontSize: 32,
                fontWeight: FontWeight.bold,
                shadows: [Shadow(blurRadius: 10, color: Colors.black)],
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "VERSIÓN ONLINE",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            const LoadingWidget(message: 'Conectando...'),
          ],
        ),
      ),
    );
  }
}
