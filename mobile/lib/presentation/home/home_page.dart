//mobile\lib\presentation\home\home_page.dart
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../../main.dart';

import '../profile/profile_page.dart';
import '../workout/workout_start_page.dart';
import '../level/level_page.dart';
import '../estadistica/statistics_page.dart';

import 'models/home_button_model.dart';
import 'widgets/home_button.dart';

import '../../data/local/database.dart';

import 'package:flutter/services.dart'; // <--- necesario para SystemNavigator
//import '../../data/local/dao/user_dao.dart';

class HomePage extends StatefulWidget {
  final UsersTableData user; // ← agregar

  const HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with RouteAware {
  final AudioPlayer _bgPlayer = AudioPlayer();

  late final String userName;

  @override
  void initState() {
    super.initState();

    userName = widget.user.gameName; // ← ahora tomamos el nombre real

    _bgPlayer.setReleaseMode(ReleaseMode.loop);
    _playMusic();
  }

  Future<void> _playMusic() async {
    await _bgPlayer.play(AssetSource("audio/music/lobby.mp3"));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)! as PageRoute);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    _bgPlayer.dispose();
    super.dispose();
  }

  @override
  void didPopNext() {
    _playMusic();
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
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ProfilePage(user: widget.user),
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
                        userName,
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
                //   BOTÓN ENTRENAMIENTO CENTRADO ABAJO
                // -------------------------
                Positioned(
                  bottom: 80,
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
                            builder: (_) => const WorkoutStartPage(),
                            //builder: (_) => const WorkoutPage(),
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
                          onTap: () {},
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
                          onTap: () {},
                          fontSize: 14,
                        ),
                        vertical: true,
                      ),
                      const SizedBox(height: 10),
                      HomeButton(
                        data: HomeButtonModel(
                          title: "Estadisticas",
                          imagePath: "assets/images/gremio_ico.png",
                          soundPath: "audio/music/entrar.mp3",
                          //onTap: () {},
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  StatisticsPage(userId: widget.user.id),
                            ),
                          ),
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
                          onTap: () {},
                          fontSize: 14,
                        ),
                        vertical: true,
                      ),
                      const SizedBox(height: 10),
                      HomeButton(
                        data: HomeButtonModel(
                          title: "Mensajería",
                          imagePath: "assets/images/mensaje_ico.png",
                          soundPath: "audio/music/entrar.mp3",
                          onTap: () {},
                          fontSize: 14,
                        ),
                        vertical: true,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: HomeButton(
                    data: HomeButtonModel(
                      title: "Salir del Juego",
                      imagePath: "assets/images/salir_ico.png",
                      soundPath: "audio/music/salir.mp3",
                      onTap: () => SystemNavigator.pop(),
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
