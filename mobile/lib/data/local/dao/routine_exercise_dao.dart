import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/routine_exercise_table.dart';

part 'routine_exercise_dao.g.dart';

@DriftAccessor(tables: [RoutineExerciseTable])
class RoutineExerciseDao extends DatabaseAccessor<AppDatabase>
    with _$RoutineExerciseDaoMixin {
  RoutineExerciseDao(super.db);

  Future<int> insertRoutineExercise(RoutineExerciseTableCompanion item) =>
      into(routineExerciseTable).insert(item);

  Future<List<RoutineExerciseTableData>> getExercisesForRoutine(
    int routineId,
  ) => (select(
    routineExerciseTable,
  )..where((t) => t.routineId.equals(routineId))).get();

  Future<int> deleteByRoutine(int routineId) => (delete(
    routineExerciseTable,
  )..where((t) => t.routineId.equals(routineId))).go();
}
