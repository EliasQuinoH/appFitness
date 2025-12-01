import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import '../../data/local/database.dart';
import '../../main.dart';
import 'package:drift/drift.dart' hide Column;
import '../onboarding/system_prompt_page.dart';
import '../../data/remote/geminis_api.dart';

import '../online/home_online_page.dart';
import '../../data/remote/models/user_model.dart';

class UserProfileFormPage extends StatefulWidget {
  final UserModel user;
  const UserProfileFormPage({super.key, required this.user});

  @override
  State<UserProfileFormPage> createState() => _UserProfileFormPageState();
}

class _UserProfileFormPageState extends State<UserProfileFormPage> {
  final TextEditingController _questionController = TextEditingController();
  String? _geminiResponse;
  bool _isLoading = false;

  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _playMusic();
  }

  Future<void> _playMusic() async {
    await _audioPlayer.play(
      AssetSource('audio/music/formulario3.mp3'),
      volume: 0.5,
    );
  }

  Future<void> _askGemini() async {
    final question = _questionController.text.trim();
    if (question.isEmpty) return;

    setState(() => _isLoading = true);
    try {
      final response = await GeminiAPI.generate(question);
      setState(() => _geminiResponse = response ?? "No hubo respuesta");
    } catch (e) {
      setState(() => _geminiResponse = "Error: $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _goNext() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const SystemPromptPage()),
    );
  }

  @override
  void dispose() {
    _audioPlayer.stop();
    _audioPlayer.dispose();
    _questionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pregunta a Gemini")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: _questionController,
              decoration: const InputDecoration(
                labelText: "Escribe tu pregunta",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : _askGemini,
              child: _isLoading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Text("Preguntar a Gemini"),
            ),
            const SizedBox(height: 20),
            if (_geminiResponse != null)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _geminiResponse!,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
