//lib\main.dart
import 'package:flutter/material.dart';
import 'presentation/splash/splash_page.dart';
import 'data/local/database.dart';

// Instancia global de la base de datos (SE CREA UNA SOLA VEZ)
final AppDatabase appDatabase = AppDatabase();

// OBSERVADOR DE RUTAS GLOBAL
final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Sembrar ejercicios base
  await appDatabase.exerciseDao.seedExercises();
  runApp(const HunterFitApp());
}

class HunterFitApp extends StatelessWidget {
  const HunterFitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Hunter Fit",
      home: const SplashPage(),
      navigatorObservers: [routeObserver], // ← necesario
    );
  }
}
