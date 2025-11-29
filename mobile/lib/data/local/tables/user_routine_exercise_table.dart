import 'package:drift/drift.dart';

class UserRoutineExerciseTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userRoutineId => integer()();
  IntColumn get exerciseId => integer()();
  IntColumn get reps => integer().nullable()();
  IntColumn get duration => integer().nullable()();
  RealColumn get intensity => real().nullable()();
}
