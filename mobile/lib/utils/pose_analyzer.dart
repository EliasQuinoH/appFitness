// lib/utils/pose_analyzer.dart
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

import 'dart:math' as math;

class PoseAnalyzer {
  // Convertir poses de MLKit a formato para el backend
  static Map<String, dynamic> poseToJson(Pose pose) {
    final Map<String, dynamic> jsonPose = {};

    pose.landmarks.forEach((type, landmark) {
      jsonPose[type.name] = {
        'x': landmark.x,
        'y': landmark.y,
        'z': landmark.z,
        'likelihood': landmark.likelihood,
      };
    });

    return jsonPose;
  }

  // Calcular ángulo entre tres puntos
  static double calcularAngulo(
    PoseLandmark puntoA,
    PoseLandmark puntoB,
    PoseLandmark puntoC,
  ) {
    final baX = puntoA.x - puntoB.x;
    final baY = puntoA.y - puntoB.y;
    final bcX = puntoC.x - puntoB.x;
    final bcY = puntoC.y - puntoB.y;

    final productoEscalar = baX * bcX + baY * bcY;
    final magnitudBA = math.sqrt(baX * baX + baY * baY);
    final magnitudBC = math.sqrt(bcX * bcX + bcY * bcY);

    if (magnitudBA == 0 || magnitudBC == 0) return 0;

    final cosTheta = productoEscalar / (magnitudBA * magnitudBC);
    final theta = math.acos(cosTheta.clamp(-1.0, 1.0));

    return theta * 180 / math.pi;
  }

  // Analizar técnica de sentadilla
  static Map<String, dynamic> analizarSentadilla(List<Pose> poses) {
    if (poses.isEmpty) return {'error': 'No se detectó pose'};

    final pose = poses.first;
    final landmarks = pose.landmarks;

    final caderaIzq = landmarks[PoseLandmarkType.leftHip];
    final rodillaIzq = landmarks[PoseLandmarkType.leftKnee];
    final tobilloIzq = landmarks[PoseLandmarkType.leftAnkle];
    final caderaDer = landmarks[PoseLandmarkType.rightHip];
    final rodillaDer = landmarks[PoseLandmarkType.rightKnee];
    final tobilloDer = landmarks[PoseLandmarkType.rightAnkle];

    if (caderaIzq == null ||
        rodillaIzq == null ||
        tobilloIzq == null ||
        caderaDer == null ||
        rodillaDer == null ||
        tobilloDer == null) {
      return {'error': 'Faltan puntos clave'};
    }

    final anguloRodillaIzq = calcularAngulo(caderaIzq, rodillaIzq, tobilloIzq);
    final anguloRodillaDer = calcularAngulo(caderaDer, rodillaDer, tobilloDer);
    final anguloPromedio = (anguloRodillaIzq + anguloRodillaDer) / 2;

    // Evaluar técnica
    int puntuacion = 100;
    final List<String> correcciones = [];

    if (anguloPromedio > 170) {
      puntuacion -= 30;
      correcciones.add('Rodillas muy extendidas');
    } else if (anguloPromedio < 90) {
      puntuacion -= 20;
      correcciones.add('Rodillas muy flexionadas');
    }

    // Verificar alineación de rodillas
    final diferenciaRodillas = (rodillaIzq.x - rodillaDer.x).abs();
    if (diferenciaRodillas > 50) {
      puntuacion -= 15;
      correcciones.add('Rodillas desalineadas');
    }

    // Verificar espalda recta (ángulo entre hombros y caderas)
    final hombroIzq = landmarks[PoseLandmarkType.leftShoulder];
    final hombroDer = landmarks[PoseLandmarkType.rightShoulder];

    if (hombroIzq != null &&
        hombroDer != null &&
        caderaIzq != null &&
        caderaDer != null) {
      final anguloEspalda = calcularAngulo(hombroIzq, caderaIzq, caderaDer);
      if (anguloEspalda < 160) {
        puntuacion -= 10;
        correcciones.add('Espalda inclinada');
      }
    }

    return {
      'puntuacion': puntuacion.clamp(0, 100),
      'angulo_rodillas': anguloPromedio,
      'correcciones': correcciones,
      'precision':
          pose.landmarks.values
              .map((l) => l.likelihood)
              .reduce((a, b) => a + b) /
          pose.landmarks.length,
    };
  }

  // Analizar técnica de flexiones
  static Map<String, dynamic> analizarFlexiones(List<Pose> poses) {
    if (poses.isEmpty) return {'error': 'No se detectó pose'};

    final pose = poses.first;
    final landmarks = pose.landmarks;

    final hombroIzq = landmarks[PoseLandmarkType.leftShoulder];
    final codoIzq = landmarks[PoseLandmarkType.leftElbow];
    final munecaIzq = landmarks[PoseLandmarkType.leftWrist];
    final hombroDer = landmarks[PoseLandmarkType.rightShoulder];
    final codoDer = landmarks[PoseLandmarkType.rightElbow];
    final munecaDer = landmarks[PoseLandmarkType.rightWrist];
    final caderaIzq = landmarks[PoseLandmarkType.leftHip];
    final caderaDer = landmarks[PoseLandmarkType.rightHip];

    if (hombroIzq == null ||
        codoIzq == null ||
        munecaIzq == null ||
        hombroDer == null ||
        codoDer == null ||
        munecaDer == null ||
        caderaIzq == null ||
        caderaDer == null) {
      return {'error': 'Faltan puntos clave'};
    }

    final anguloCodoIzq = calcularAngulo(hombroIzq, codoIzq, munecaIzq);
    final anguloCodoDer = calcularAngulo(hombroDer, codoDer, munecaDer);
    final anguloPromedio = (anguloCodoIzq + anguloCodoDer) / 2;

    int puntuacion = 100;
    final List<String> correcciones = [];

    // Evaluar ángulo de codos
    if (anguloPromedio > 160) {
      puntuacion -= 25;
      correcciones.add('Codios muy extendidos');
    } else if (anguloPromedio < 80) {
      puntuacion -= 20;
      correcciones.add('Codios muy flexionados');
    }

    // Verificar alineación cuerpo
    final caderaMediaY = (caderaIzq.y + caderaDer.y) / 2;
    final hombroMediaY = (hombroIzq.y + hombroDer.y) / 2;
    final diferenciaAltura = (caderaMediaY - hombroMediaY).abs();

    if (diferenciaAltura > 30) {
      puntuacion -= 15;
      correcciones.add('Cuerpo desalineado');
    }

    return {
      'puntuacion': puntuacion.clamp(0, 100),
      'angulo_codos': anguloPromedio,
      'correcciones': correcciones,
      'precision':
          pose.landmarks.values
              .map((l) => l.likelihood)
              .reduce((a, b) => a + b) /
          pose.landmarks.length,
    };
  }
}
