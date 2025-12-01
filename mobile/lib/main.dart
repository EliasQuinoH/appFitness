//lib\main.dart
import 'package:flutter/material.dart';
//import 'presentation/splash/splash_page.dart'; offline
import 'data/local/database.dart';
import 'data/remote/geminis_api.dart';

import 'presentation/online/splash_online_page.dart'; // ← Nuevoonline

// Instancia global de la base de datos (SE CREA UNA SOLA VEZ)
final AppDatabase appDatabase = AppDatabase();

// OBSERVADOR DE RUTAS GLOBAL
final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Sembrar ejercicios base
  await appDatabase.exerciseDao.seedExercises();
  GeminiAPI.initialize();
  runApp(const HunterFitApp());
}

class HunterFitApp extends StatelessWidget {
  const HunterFitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Hunter Fit",
      // Por defecto va al splash online, pero podemos cambiarlo fácilmente
      home: const SplashOnlinePage(), // ← Cambiado a online por defecto
      // home: const SplashPage(), // ← Para usar offline
      navigatorObservers: [routeObserver], // ← necesario
    );
  }
}
