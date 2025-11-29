//lib\presentation\onboarding\system_prompt_page.dart
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../onboarding/user_registration_page.dart';
import '../../widgets/button/animated_click_button.dart';

class SystemPromptPage extends StatefulWidget {
  const SystemPromptPage({super.key});

  @override
  State<SystemPromptPage> createState() => _SystemPromptPageState();
}

class _SystemPromptPageState extends State<SystemPromptPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleYAnimation;
  late Animation<double> _scaleAnimation;

  final AudioPlayer _player = AudioPlayer();

  @override
  void initState() {
    super.initState();

    // Controlador de animación de 2 segundos
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // Animación de "apertura" vertical desde el centro (0 → 1)
    _scaleYAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    // Pequeño zoom-in para darle más vida a la apertura
    _scaleAnimation = Tween<double>(
      begin: 0.92,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // Iniciar animación
    _controller.forward();

    // Reproducir audio
    _player.play(AssetSource("audio/music/system.mp3"));
  }

  @override
  void dispose() {
    _controller.dispose();
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    double hudWidth = size.width * 0.95;
    double hudHeight = hudWidth * (550 / 1148);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (_, child) {
            return Align(
              alignment: Alignment.center,
              child: ClipRect(
                child: Align(
                  alignment: Alignment.center,
                  heightFactor: _scaleYAnimation.value,
                  child: Transform.scale(
                    scale: _scaleAnimation.value,
                    child: child,
                  ),
                ),
              ),
            );
          },
          child: SizedBox(
            width: hudWidth,
            height: hudHeight,
            child: Stack(
              alignment: Alignment.center,
              children: [
                IgnorePointer(
                  ignoring: true,
                  child: Image.asset(
                    'assets/images/quest_frame_bg.png',
                    width: hudWidth,
                    height: hudHeight,
                    fit: BoxFit.fill,
                  ),
                ),

                Positioned(
                  top: hudHeight * 0.16,
                  left: 50,
                  right: 40,
                  child: Column(
                    children: [
                      Text(
                        "Has adquirido las cualificaciones para ser un JUGADOR.\n\n¿Aceptarías?",
                        style: TextStyle(
                          color: Colors.purpleAccent.shade100,
                          fontSize: hudWidth * 0.038,
                          fontWeight: FontWeight.bold,
                          height: 1.25,
                          shadows: const [
                            Shadow(blurRadius: 20, color: Color(0xFFB54CFF)),
                            Shadow(blurRadius: 40, color: Color(0xFF8000FF)),
                            Shadow(blurRadius: 60, color: Color(0xFF6A00F4)),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: hudHeight * 0.06),

                      // BOTONES
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // ===========================
                          // BOTÓN NO (animado + sonido)
                          // ===========================
                          AnimatedClickButton(
                            sound: "audio/music/click.mp3",
                            onTap: () => Navigator.pop(context),
                            child: Text(
                              "NO",
                              style: TextStyle(
                                color: Colors.purpleAccent.shade200,
                                fontSize: hudWidth * 0.045,
                                fontWeight: FontWeight.bold,
                                shadows: const [
                                  Shadow(
                                    blurRadius: 15,
                                    color: Color(0xFF8A2BE2),
                                  ),
                                  Shadow(
                                    blurRadius: 30,
                                    color: Color(0xFFB54CFF),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // ===========================
                          // BOTÓN SI (animado + sonido)
                          // ===========================
                          AnimatedClickButton(
                            sound: "audio/music/click.mp3",
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const UserRegistrationPage(),
                                ),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: hudHeight * 0.035,
                                horizontal: hudWidth * 0.10,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.purpleAccent.shade100.withAlpha(
                                  90,
                                ),
                                borderRadius: BorderRadius.circular(14),
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 15,
                                    color: Colors.purpleAccent,
                                  ),
                                ],
                              ),
                              child: Text(
                                "SI",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: hudWidth * 0.045,
                                  fontWeight: FontWeight.bold,
                                  shadows: const [
                                    Shadow(
                                      blurRadius: 20,
                                      color: Color(0xFFDA70FF),
                                    ),
                                    Shadow(
                                      blurRadius: 30,
                                      color: Color(0xFFB54CFF),
                                    ),
                                    Shadow(
                                      blurRadius: 55,
                                      color: Color(0xFF8A2BE2),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
