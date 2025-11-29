//lib\presentation\workout\workout_start_page.dart
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'mlkit_camera_page.dart';

class WorkoutStartPage extends StatefulWidget {
  const WorkoutStartPage({super.key});

  @override
  State<WorkoutStartPage> createState() => _WorkoutStartPageState();
}

class _WorkoutStartPageState extends State<WorkoutStartPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleYAnimation;
  late Animation<double> _scaleAnimation;

  final AudioPlayer _player = AudioPlayer();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 25),
    );

    _scaleYAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _scaleAnimation = Tween<double>(
      begin: 0.92,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();

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

    double imgWidth = size.width * 0.75;
    double imgHeight = imgWidth * (16 / 9);

    return Scaffold(
      body: Stack(
        children: [
          // FONDO
          SizedBox.expand(
            child: Image.asset(
              "assets/images/entrenamiento.jpg",
              fit: BoxFit.cover,
            ),
          ),

          // CONTENIDO
          SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ANIMACIÓN DEL MARCO
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (_, child) {
                      return ClipRect(
                        child: Align(
                          alignment: Alignment.center,
                          heightFactor: _scaleYAnimation.value,
                          child: Transform.scale(
                            scale: _scaleAnimation.value,
                            child: child,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: imgWidth,
                      height: imgHeight,
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage(
                            "assets/images/quest_frame_bg32.png",
                          ),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.all(20),
                      child: _buildExerciseList(),
                    ),
                  ),

                  const SizedBox(height: 45),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // LISTA DE EJERCICIOS
  Widget _buildExerciseList() {
    final ejercicios = [
      "Sentadillas",
      "Flexiones",
      "Abdominales",
      "Saltos de Tijera",
      "Plancha",
    ];

    return ListView.builder(
      itemCount: ejercicios.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.40),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                ejercicios[index],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          MLKitCameraPage(exercise: ejercicios[index]),
                    ),
                  );
                },

                child: const Text("Iniciar"),
              ),
            ],
          ),
        );
      },
    );
  }
}
