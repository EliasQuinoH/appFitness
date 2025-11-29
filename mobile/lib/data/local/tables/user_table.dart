//lib\data\local\tables\user_table.dart
import 'package:drift/drift.dart';

class UsersTable extends Table {
  // ID local autoincremental. Nunca cambia.
  IntColumn get id => integer().autoIncrement()();

  // ID del servidor Django (único, pero puede ser null si aún no se sincronizó)
  TextColumn get remoteUserId => text().nullable().unique()();

  // Email del usuario
  TextColumn get email => text().withLength(min: 5, max: 255).unique()();

  // Nombre visible del jugador
  TextColumn get gameName => text().withLength(min: 3, max: 50)();

  // Nivel actual
  IntColumn get level => integer()();

  // Experiencia acumulada
  IntColumn get experiencePoints => integer().withDefault(const Constant(0))();

  // Total de entrenamientos
  IntColumn get totalWorkouts => integer().withDefault(const Constant(0))();

  // ESTADO DE SINCRONIZACIÓN:
  // 0: sincronizado
  // 1: pendiente de crear
  // 2: pendiente de actualizar
  IntColumn get syncStatus => integer().withDefault(const Constant(0))();

  // Fecha de última modificación local
  DateTimeColumn get lastModified =>
      dateTime().withDefault(currentDateAndTime)();

  // ✅ Columna para usuario activo
  BoolColumn get isActive => boolean().withDefault(const Constant(false))();
  // Email único localmente
  @override
  List<Set<Column>>? get uniqueKeys => [
    {email},
  ];
}
