//mobile\lib\data\local\tables\exercise_table.dart
import 'package:drift/drift.dart';

class ExerciseTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  TextColumn get type => text().nullable()();
}
