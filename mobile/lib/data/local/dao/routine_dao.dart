import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/routine_table.dart';

part 'routine_dao.g.dart';

@DriftAccessor(tables: [RoutineTable])
class RoutineDao extends DatabaseAccessor<AppDatabase> with _$RoutineDaoMixin {
  RoutineDao(super.db);

  Future<int> insertRoutine(RoutineTableCompanion routine) =>
      into(routineTable).insert(routine);

  Future<List<RoutineTableData>> getAllRoutines() => select(routineTable).get();

  Future<RoutineTableData?> getRoutine(int id) =>
      (select(routineTable)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<bool> updateRoutine(RoutineTableData routine) =>
      update(routineTable).replace(routine);

  Future<int> deleteRoutine(int id) =>
      (delete(routineTable)..where((t) => t.id.equals(id))).go();
}
