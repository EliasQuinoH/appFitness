import 'package:audioplayers/audioplayers.dart';

class AudioManager {
  static final AudioPlayer _sfxPlayer = AudioPlayer();

  /// Reproduce un sonido corto y espera a que termine
  static Future<void> playButtonSound(String path) async {
    await _sfxPlayer.stop();
    await _sfxPlayer.play(AssetSource(path));

    // Esperar a que termine
    await Future.delayed(
      const Duration(milliseconds: 900),
    ); // 0.9s por seguridad
  }
}
