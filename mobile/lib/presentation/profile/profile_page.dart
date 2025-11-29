//mobile/lib/presentation/profile/profile_page.dart
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../../data/local/database.dart';
import '../onboarding/login_page.dart';
import '../../main.dart'; // para usar appDatabase

class ProfilePage extends StatefulWidget {
  final UsersTableData user;

  const ProfilePage({super.key, required this.user});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<void> _logout() async {
    final player = AudioPlayer();
    await player.play(AssetSource("audio/music/salir.mp3"));

    // Esperar 1 segundo para que termine el sonido
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;
    // 🔹 Marcar usuario como inactivo
    await appDatabase.userDao.deactivateAllUsers(); // desactiva todos
    // Limpiar toda la pila y redirigir a LoginPage
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.user;

    return Scaffold(
      body: Stack(
        children: [
          // -------------------------
          // Fondo de pantalla
          // -------------------------
          SizedBox.expand(
            child: Image.asset(
              "assets/images/entrenamiento1.jpg", // <--- tu fondo estilo juego
              fit: BoxFit.cover,
            ),
          ),

          // -------------------------
          // Contenido principal
          // -------------------------
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // -------------------------
                  // Foto de perfil central
                  // -------------------------
                  Center(
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage(
                        "assets/images/avatar.png", // <--- foto de perfil
                      ),
                      backgroundColor: Colors.transparent,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // -------------------------
                  // Información del jugador
                  // -------------------------
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      // color: Colors.black.withOpacity(0.6),
                      color: Colors.black.withValues(
                        alpha: 153,
                      ), // 153 ≈ 0.6 * 255
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.purpleAccent, width: 2),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Email: ${user.email}",
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Nombre: ${user.gameName}",
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Nivel: ${user.level}",
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Experiencia: ${user.experiencePoints}",
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Entrenamientos: ${user.totalWorkouts}",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  // -------------------------
                  // Botón cerrar sesión
                  // -------------------------
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 24,
                      ),
                    ),
                    icon: Image.asset(
                      "assets/images/salir_ico.png",
                      width: 24,
                      height: 24,
                    ),
                    label: const Text(
                      "Cerrar sesión",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    onPressed: _logout,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
