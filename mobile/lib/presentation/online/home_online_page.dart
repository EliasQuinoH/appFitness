// lib/presentacion/online/home_online_page.dart
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../workout/workout_start_page.dart';
import '../level/level_page.dart';
//import '../estadistica/statistics_page.dart';
import '../home/models/home_button_model.dart';
import '../home/widgets/home_button.dart';
import 'package:flutter/services.dart';

import '../../data/remote/models/user_model.dart'; //user tabla
//import '../../data/remote/models/rutina_model.dart';//rutina tabla

import '../../services/auth_service.dart';
import '../online/ejercicios_online_page.dart';
import '../online/rutinas_online_page.dart';
import '../online/login_online_page.dart';
import '../online/profile_online_page.dart';
import '../online/misiones_online_page.dart';
import '../online/statistics_online_page.dart';
import '../online/workout_online_page.dart';

class HomeOnlinePage extends StatefulWidget {
  final UserModel user;

  const HomeOnlinePage({super.key, required this.user});

  @override
  State<HomeOnlinePage> createState() => _HomeOnlinePageState();
}

class _HomeOnlinePageState extends State<HomeOnlinePage> {
  final AudioPlayer _bgPlayer = AudioPlayer();
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _bgPlayer.setReleaseMode(ReleaseMode.loop);
    _playMusic();
  }

  Future<void> _playMusic() async {
    await _bgPlayer.play(AssetSource("audio/music/lobby.mp3"));
  }

  Future<void> _logout() async {
    await _authService.logout();

    if (!mounted) return;

    // Navegar al login online
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginOnlinePage()),
      (route) => false, // Remover todas las rutas anteriores
    );
  }

  @override
  void dispose() {
    _bgPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// Fondo
          SizedBox.expand(
            child: Image.asset("assets/images/loby3.jpg", fit: BoxFit.cover),
          ),

          /// UI
          SafeArea(
            child: Stack(
              children: [
                // -------------------------
                //   BOTÓN PERFIL + NOMBRE (IZQUIERDA)
                // -------------------------
                Positioned(
                  top: 10,
                  left: 10,
                  child: Row(
                    children: [
                      /// ICONO ESTANDARTE
                      Image.asset(
                        "assets/images/estandarte_ico.png",
                        width: 40,
                        height: 40,
                      ),

                      const SizedBox(width: 10),

                      /// BOTÓN PERFIL
                      GestureDetector(
                        /*onTap: () {
                          //  Crear ProfileOnlinePage
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Perfil Online - Próximamente'),
                            ),
                          );
                        },*/
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  ProfileOnlinePage(user: widget.user),
                            ),
                          );
                        },
                        child: Image.asset(
                          "assets/images/perfil_ico.png",
                          width: 50,
                          height: 50,
                        ),
                      ),

                      const SizedBox(width: 10),

                      /// LABEL DEL USUARIO
                      Text(
                        widget.user.nombreUsuario,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          shadows: [Shadow(blurRadius: 8, color: Colors.black)],
                        ),
                      ),
                    ],
                  ),
                ),

                // -------------------------
                //   INFORMACIÓN DE USUARIO ONLINE (PUNTOS, CRISTALES)
                // -------------------------
                Positioned(
                  top: 70,
                  left: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Puntos: ${widget.user.puntosExperiencia}",
                        style: const TextStyle(
                          color: Colors.yellow,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          shadows: [Shadow(blurRadius: 4, color: Colors.black)],
                        ),
                      ),
                      Text(
                        "Cristales: ${widget.user.cristalesMagicos}",
                        style: const TextStyle(
                          color: Colors.cyan,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          shadows: [Shadow(blurRadius: 4, color: Colors.black)],
                        ),
                      ),
                      Text(
                        "Nivel: ${widget.user.nivelFisicoActual}",
                        style: const TextStyle(
                          color: Colors.green,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          shadows: [Shadow(blurRadius: 4, color: Colors.black)],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 10,
                  top: 140,
                  child: Column(
                    children: [
                      HomeButton(
                        data: HomeButtonModel(
                          title: "Ejercicios",
                          imagePath: "assets/images/entrenamiento_ico.png",
                          soundPath: "audio/music/entrar.mp3",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const EjerciciosOnlinePage(),
                              ),
                            );
                          },
                          fontSize: 14,
                        ),
                        vertical: true,
                      ),
                      const SizedBox(height: 10),
                      HomeButton(
                        data: HomeButtonModel(
                          title: "Rutinas",
                          imagePath: "assets/images/rutina_ico.png",
                          soundPath: "audio/music/entrar.mp3",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const RutinasOnlinePage(),
                              ),
                            );
                          },
                          fontSize: 14,
                        ),
                        vertical: true,
                      ),
                      const SizedBox(height: 10),
                      HomeButton(
                        data: HomeButtonModel(
                          title: "Misiones",
                          imagePath: "assets/images/misiones_ico.png",
                          soundPath: "audio/music/entrar.mp3",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const MisionesOnlinePage(),
                              ),
                            );
                          },
                          fontSize: 14,
                        ),
                        vertical: true,
                      ),
                      const SizedBox(height: 10),
                      HomeButton(
                        data: HomeButtonModel(
                          title: "Estadisticas",
                          imagePath: "assets/images/estadistica_ico.png",
                          soundPath: "audio/music/entrar.mp3",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const StatisticsOnlinePage(),
                              ),
                            );
                          },
                          fontSize: 14,
                        ),
                        vertical: true,
                      ),
                    ],
                  ),
                ),

                // -------------------------
                //   BOTÓN ENTRENAMIENTO CENTRADO ABAJO
                // -------------------------
                Positioned(
                  bottom: 40,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: HomeButton(
                      data: HomeButtonModel(
                        title: "Entrenamiento",
                        imagePath: "assets/images/entrenamiento_ico.png",
                        soundPath: "audio/music/entrar.mp3",
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            //builder: (_) => const WorkoutStartPage(),
                            builder: (_) => const WorkoutOnlinePage(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // -------------------------
                //   COLUMNA DERECHA (NIVELES)
                // -------------------------
                Positioned(
                  right: 10,
                  top: 140,
                  child: Column(
                    children: [
                      HomeButton(
                        data: HomeButtonModel(
                          title: "Niveles",
                          imagePath: "assets/images/nivel_ico.png",
                          soundPath: "audio/music/entrar.mp3",
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LevelPage(),
                            ),
                          ),
                          fontSize: 14,
                        ),
                        vertical: true,
                      ),
                      const SizedBox(height: 10),
                      HomeButton(
                        data: HomeButtonModel(
                          title: "Tienda",
                          imagePath: "assets/images/tienda_ico.png",
                          soundPath: "audio/music/entrar.mp3",
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Tienda Online - Próximamente'),
                              ),
                            );
                          },
                          fontSize: 14,
                        ),
                        vertical: true,
                      ),
                      const SizedBox(height: 10),
                      HomeButton(
                        data: HomeButtonModel(
                          title: "Gremios",
                          imagePath: "assets/images/estadistica_ico.png",
                          soundPath: "audio/music/entrar.mp3",
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Gremios - Próximamente'),
                              ),
                            );
                          },
                          fontSize: 14,
                        ),
                        vertical: true,
                      ),
                      const SizedBox(height: 10),

                      HomeButton(
                        data: HomeButtonModel(
                          title: "Ranking",
                          imagePath:
                              "assets/images/ranking_ico.png", // Necesitarás este icono
                          soundPath: "audio/music/entrar.mp3",
                          onTap: () {
                            // TODO: Crear RankingOnlinePage
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Ranking - Próximamente'),
                              ),
                            );
                          },
                          fontSize: 14,
                        ),
                        vertical: true,
                      ),
                    ],
                  ),
                ),

                // -------------------------
                //   BOTÓN SALIR (LOGOUT)
                // -------------------------
                Positioned(
                  top: 10,
                  right: 10,
                  child: HomeButton(
                    data: HomeButtonModel(
                      title: "Cerrar Sesión",
                      imagePath: "assets/images/salir_ico.png",
                      soundPath: "audio/music/salir.mp3",
                      onTap: _logout,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
