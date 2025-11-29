import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/user_routine_exercise_table.dart';

part 'user_routine_exercise_dao.g.dart';

@DriftAccessor(tables: [UserRoutineExerciseTable])
class UserRoutineExerciseDao extends DatabaseAccessor<AppDatabase>
    with _$UserRoutineExerciseDaoMixin {
  UserRoutineExerciseDao(super.db);

  Future<int> insertUserRoutineExercise(
    UserRoutineExerciseTableCompanion item,
  ) => into(userRoutineExerciseTable).insert(item);

  Future<List<UserRoutineExerciseTableData>> getExercisesByUserRoutine(
    int userRoutineId,
  ) => (select(
    userRoutineExerciseTable,
  )..where((t) => t.userRoutineId.equals(userRoutineId))).get();

  Future<int> deleteByRoutine(int userRoutineId) => (delete(
    userRoutineExerciseTable,
  )..where((t) => t.userRoutineId.equals(userRoutineId))).go();
}
