import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/exercise_table.dart';

part 'exercise_dao.g.dart';

@DriftAccessor(tables: [ExerciseTable])
class ExerciseDao extends DatabaseAccessor<AppDatabase>
    with _$ExerciseDaoMixin {
  ExerciseDao(super.db);

  Future<int> insertExercise(ExerciseTableCompanion ex) =>
      into(exerciseTable).insert(ex);

  Future<List<ExerciseTableData>> getAllExercises() =>
      select(exerciseTable).get();

  Future<ExerciseTableData?> getExercise(int id) =>
      (select(exerciseTable)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<bool> updateExercise(ExerciseTableData ex) =>
      update(exerciseTable).replace(ex);

  Future<int> deleteExercise(int id) =>
      (delete(exerciseTable)..where((t) => t.id.equals(id))).go();

  /// Inserta los ejercicios base si no existen
  Future<void> seedExercises() async {
    final existing = await getAllExercises();
    if (existing.isNotEmpty) return; // Ya están creados

    final exercises = [
      ExerciseTableCompanion(
        name: Value("Sentadillas"),
        description: Value("Ejercicio de piernas"),
        type: Value("Piernas"),
      ),
      ExerciseTableCompanion(
        name: Value("Flexiones"),
        description: Value("Ejercicio de pecho y brazos"),
        type: Value("Pecho"),
      ),
      ExerciseTableCompanion(
        name: Value("Plancha"),
        description: Value("Ejercicio de core"),
        type: Value("Core"),
      ),
      ExerciseTableCompanion(
        name: Value("Jumping Jacks"),
        description: Value("Ejercicio cardiovascular"),
        type: Value("Cardio"),
      ),
    ];

    await batch((batch) => batch.insertAll(exerciseTable, exercises));
  }
}
