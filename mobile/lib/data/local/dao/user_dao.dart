// lib/data/local/dao/user_dao.dart
import 'package:drift/drift.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../database.dart';
import '../tables/user_table.dart';

part 'user_dao.g.dart';

@DriftAccessor(tables: [UsersTable])
class UserDao extends DatabaseAccessor<AppDatabase> with _$UserDaoMixin {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  UserDao(super.db);

  // ==========================
  // CRUD básico
  // ==========================

  // Obtener todos los usuarios locales
  Future<List<UsersTableData>> getAllUsers() => select(usersTable).get();

  // Obtener usuario por email
  Future<UsersTableData?> getUserByEmail(String email) {
    return (select(
      usersTable,
    )..where((tbl) => tbl.email.equals(email))).getSingleOrNull();
  }

  // Obtener usuario por ID
  Future<UsersTableData?> getUserById(int id) {
    return (select(
      usersTable,
    )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  // Insertar usuario local
  Future<int> insertUser(UsersTableCompanion user) =>
      into(usersTable).insert(user);

  // Actualizar usuario local
  Future<bool> updateUser(UsersTableData user) =>
      update(usersTable).replace(user);

  // Eliminar usuario local
  Future<int> deleteUser(int id) =>
      (delete(usersTable)..where((tbl) => tbl.id.equals(id))).go();

  // ==========================
  // Gestión de tokens seguros
  // ==========================

  Future<void> saveTokens({
    required String email,
    required String accessToken,
    required String refreshToken,
  }) async {
    await _secureStorage.write(key: '${email}_access', value: accessToken);
    await _secureStorage.write(key: '${email}_refresh', value: refreshToken);
  }

  Future<String?> getAccessToken(String email) async {
    return _secureStorage.read(key: '${email}_access');
  }

  Future<String?> getRefreshToken(String email) async {
    return _secureStorage.read(key: '${email}_refresh');
  }

  Future<void> deleteTokens(String email) async {
    await _secureStorage.delete(key: '${email}_access');
    await _secureStorage.delete(key: '${email}_refresh');
  }

  // ==========================
  // Usuarios activos y sincronización
  // ==========================

  // Obtener usuario activo real
  Future<UsersTableData?> getActiveUser() {
    return (select(
      usersTable,
    )..where((t) => t.isActive.equals(true))).getSingleOrNull();
  }

  // Activar usuario al iniciar sesión
  Future<void> setActiveUser(int id) async {
    // Poner todos como inactivos
    await update(
      usersTable,
    ).write(UsersTableCompanion(isActive: const Value(false)));

    // Activar solo el usuario que inicia sesión
    await (update(usersTable)..where((t) => t.id.equals(id))).write(
      UsersTableCompanion(isActive: const Value(true)),
    );
  }

  // Desactivar todos los usuarios (cerrar sesión)
  Future<void> deactivateAllUsers() async {
    await update(
      usersTable,
    ).write(UsersTableCompanion(isActive: const Value(false)));
  }

  // Marcar usuario como sincronizado
  Future<void> markAsSynced(int id) async {
    await (update(usersTable)..where((tbl) => tbl.id.equals(id))).write(
      UsersTableCompanion(syncStatus: const Value(0)),
    );
  }
}
