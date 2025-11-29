import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/user_profile_table.dart';

part 'user_profile_dao.g.dart';

@DriftAccessor(tables: [UserProfileTable])
class UserProfileDao extends DatabaseAccessor<AppDatabase>
    with _$UserProfileDaoMixin {
  UserProfileDao(super.db);

  // Insertar perfil
  Future<int> insertProfile(UserProfileTableCompanion profile) =>
      into(userProfileTable).insert(profile);

  // Obtener perfil por usuario
  Future<UserProfileTableData?> getProfileByUser(int userId) {
    return (select(
      userProfileTable,
    )..where((tbl) => tbl.userId.equals(userId))).getSingleOrNull();
  }

  // Actualizar
  Future<bool> updateProfile(UserProfileTableData profile) =>
      update(userProfileTable).replace(profile);

  // Borrar
  Future<int> deleteProfile(int id) =>
      (delete(userProfileTable)..where((tbl) => tbl.id.equals(id))).go();
}
