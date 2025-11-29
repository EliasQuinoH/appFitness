import 'package:flutter/material.dart';

class LevelPage extends StatelessWidget {
  const LevelPage({super.key});

  @override
  Widget build(BuildContext context) {
    double currentXP = 50;
    double maxXP = 200;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Niveles"),
        backgroundColor: Colors.orangeAccent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),

            Text(
              "Nivel Actual: 1",
              style: TextStyle(
                color: Colors.orangeAccent.shade100,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            // Barra de EXP
            _buildXPBar(currentXP, maxXP),

            const SizedBox(height: 40),

            // Lista de recompensas por nivel
            Expanded(
              child: ListView(
                children: [
                  _levelReward(1, "Desbloqueas una medalla inicial"),
                  _levelReward(2, "Nuevo ejercicio: Sentadillas avanzadas"),
                  _levelReward(3, "Modo entrenamiento intenso"),
                  _levelReward(4, "Aumento de 5% en XP por ejercicio"),
                  _levelReward(5, "Título: Hunter Aprendiz"),
                ],
              ),
            ),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orangeAccent,
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 40,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "Volver",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildXPBar(double value, double max) {
    double progress = value / max;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "XP: ${value.toInt()} / ${max.toInt()}",
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 20,
            backgroundColor: Colors.white10,
            valueColor: const AlwaysStoppedAnimation(Colors.orangeAccent),
          ),
        ),
      ],
    );
  }

  Widget _levelReward(int level, String reward) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.orangeAccent, width: 1),
      ),
      child: Row(
        children: [
          Text(
            "Nivel $level:\n",
            style: const TextStyle(
              color: Colors.orangeAccent,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              reward,
              style: const TextStyle(color: Colors.white70, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
