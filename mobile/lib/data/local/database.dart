// lib/data/local/database.dart
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

// ============= TABLAS =============
import 'tables/user_table.dart';
import 'tables/user_profile_table.dart';
import 'tables/exercise_table.dart';
import 'tables/routine_table.dart';
import 'tables/routine_exercise_table.dart';
import 'tables/user_routine_table.dart';
import 'tables/user_routine_exercise_table.dart';

// ============= DAOs =============
import 'dao/user_dao.dart';
import 'dao/user_profile_dao.dart';
import 'dao/exercise_dao.dart';
import 'dao/routine_dao.dart';
import 'dao/routine_exercise_dao.dart';
import 'dao/user_routine_dao.dart';
import 'dao/user_routine_exercise_dao.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [
    UsersTable,
    UserProfileTable,
    ExerciseTable,
    RoutineTable,
    RoutineExerciseTable,
    UserRoutineTable,
    UserRoutineExerciseTable,
  ],

  daos: [
    UserDao,
    UserProfileDao,
    ExerciseDao,
    RoutineDao,
    RoutineExerciseDao,
    UserRoutineDao,
    UserRoutineExerciseDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // Aquí podrías agregar migraciones futuras
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'hunter_fit.sqlite'));
    return NativeDatabase(file);
  });
}
