//mobile\lib\presentation\splash\splash_page.dart
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:audioplayers/audioplayers.dart';

import '../onboarding/user_profile_form_page.dart';
import '../../data/local/database.dart'; // IMPORTANTE
import '../home/home_page.dart'; // A donde navega si ya hay usuario
import '../../main.dart'; // para usar appDatabase
import '../onboarding/system_prompt_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late AnimationController _logoController;
  late Animation<double> _logoAnimation;

  late AnimationController _textController;
  late Animation<double> _textAnimation;

  final AudioPlayer _player = AudioPlayer();
  // INSTANCIA DE BD
  late final AppDatabase _db;

  @override
  void initState() {
    super.initState();

    _db = appDatabase; // INIT BD

    _initAnimations();
    _playMusic();
    _checkUser(); // 👈 VALIDACIÓN DE USUARIO
  }

  void _initAnimations() {
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _logoAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeInOut),
    );

    _textController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..forward();

    _textAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _textController, curve: Curves.easeIn));
  }

  void _playMusic() {
    _player.play(AssetSource("audio/music/splash_intro.mp3"));
  }

  /// 🔥 AQUÍ OCURRE LA VALIDACIÓN REAL
  Future<void> _checkUser() async {
    await Future.delayed(const Duration(seconds: 2)); // que la animación se vea

    final user = await _db.userDao.getActiveUser();

    if (!mounted) return;

    if (user != null) {
      // 👌 Usuario encontrado →
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomePage(user: user)),
      );
    } else {
      //  No hay usuario → ir al registro / system prompt
      Navigator.pushReplacement(
        context,
        //MaterialPageRoute(builder: (_) => const UserProfileFormPage()),
        MaterialPageRoute(builder: (_) => const SystemPromptPage()),
      );
    }
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Lottie.asset(
            'assets/animations/splash.json',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
            repeat: true,
          ),
          ScaleTransition(
            scale: _logoAnimation,
            child: Image.asset(
              'assets/images/icono_app.png',
              width: 150,
              height: 150,
            ),
          ),
          Positioned(
            bottom: 100,
            child: FadeTransition(
              opacity: _textAnimation,
              child: const Text(
                "Hunter Fit",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  shadows: [
                    Shadow(
                      blurRadius: 8,
                      color: Colors.blueAccent,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
