//mobile\lib\data\local\tables\user_profile_table.dart
import 'package:drift/drift.dart';

class UserProfileTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId => integer()();

  RealColumn get weight => real()();
  RealColumn get height => real()();
  IntColumn get age => integer().nullable()();

  TextColumn get issues => text().nullable()();
  TextColumn get pains => text().nullable()();
  TextColumn get comments => text().nullable()();
}
