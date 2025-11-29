import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/user_routine_table.dart';

part 'user_routine_dao.g.dart';

@DriftAccessor(tables: [UserRoutineTable])
class UserRoutineDao extends DatabaseAccessor<AppDatabase>
    with _$UserRoutineDaoMixin {
  UserRoutineDao(super.db);

  Future<int> insertUserRoutine(UserRoutineTableCompanion item) =>
      into(userRoutineTable).insert(item);

  Future<List<UserRoutineTableData>> getRoutinesByUser(int userId) =>
      (select(userRoutineTable)..where((t) => t.userId.equals(userId))).get();

  Future<int> deleteUserRoutine(int id) =>
      (delete(userRoutineTable)..where((tbl) => tbl.id.equals(id))).go();
}
