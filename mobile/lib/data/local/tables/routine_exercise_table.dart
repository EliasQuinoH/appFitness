import 'package:drift/drift.dart';

class RoutineExerciseTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get routineId => integer()();
  IntColumn get exerciseId => integer()();
  IntColumn get reps => integer().nullable()();
  IntColumn get duration => integer().nullable()();
}
