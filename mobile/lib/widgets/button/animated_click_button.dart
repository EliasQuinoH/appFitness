// lib/widgets/button/animated_click_button.dart
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AnimatedClickButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;
  final String sound;

  const AnimatedClickButton({
    super.key,
    required this.child,
    required this.onTap,
    required this.sound,
  });

  @override
  State<AnimatedClickButton> createState() => _AnimatedClickButtonState();
}

class _AnimatedClickButtonState extends State<AnimatedClickButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  // ⚡ Player optimizado para efectos cortos
  final AudioPlayer _player = AudioPlayer()
    ..setPlayerMode(PlayerMode.lowLatency);

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120), // animación rápida
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.92,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  void _playClickSound() {
    _player.stop(); // detiene cualquier sonido anterior
    _player.play(AssetSource(widget.sound)); // reproduce instantáneo
  }

  @override
  void dispose() {
    _controller.dispose();
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTapDown: (_) => _controller.forward(),
      onTapCancel: () => _controller.reverse(),
      onTapUp: (_) {
        _playClickSound(); // sonido instantáneo
        _controller.reverse();

        // 🔹 Retraso breve para que se escuche el clic antes de navegar
        Future.delayed(const Duration(milliseconds: 150), () {
          widget.onTap();
        });
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, child) {
          return Transform.scale(scale: _scaleAnimation.value, child: child);
        },
        child: widget.child,
      ),
    );
  }
}
