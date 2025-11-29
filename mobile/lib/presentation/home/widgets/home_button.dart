// lib/presentation/home/widgets/home_button.dart
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../models/home_button_model.dart';

class HomeButton extends StatelessWidget {
  final HomeButtonModel data;
  final bool vertical; // true para columna

  final AudioPlayer sfxPlayer = AudioPlayer();

  HomeButton({super.key, required this.data, this.vertical = false});

  Future<void> _playSound() async {
    await sfxPlayer.stop();
    await sfxPlayer.play(AssetSource(data.soundPath));
    await Future.delayed(const Duration(milliseconds: 900));
  }

  @override
  Widget build(BuildContext context) {
    final Widget content = vertical
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(data.imagePath, width: 40, height: 40),
              if (data.title.isNotEmpty)
                Text(
                  data.title,
                  style: TextStyle(
                    fontSize: data.fontSize ?? 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: const [Shadow(blurRadius: 5, color: Colors.black)],
                  ),
                ),
            ],
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(data.imagePath, width: 50, height: 50),
              const SizedBox(width: 12),
              Text(
                data.title,
                style: TextStyle(
                  fontSize: data.fontSize ?? 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: const [Shadow(blurRadius: 12, color: Colors.black)],
                ),
              ),
            ],
          );

    return TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(12),
        foregroundColor: Colors.white,
      ),
      onPressed: () async {
        await _playSound();
        data.onTap();
      },
      child: content,
    );
  }
}
