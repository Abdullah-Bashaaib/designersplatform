import 'package:dartz/dartz.dart';
import 'package:designers_platform/core/utils/key_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/designer_model.dart';

abstract class DesignerLocalDataSource {
  Future<DesignerModel> getData(String id);
  Future<Unit> updateData(DesignerModel designer);
  // Future<Unit> deleteData(String id);
}

class DesignerLocalDataSourceBySharedPref implements DesignerLocalDataSource {
  final SharedPreferences sharedPreferences;
  DesignerLocalDataSourceBySharedPref({required this.sharedPreferences});

  @override
  Future<DesignerModel> getData(String id) async {
    return DesignerModel(
      id: KeySharedPref.kUserId,
      name: KeySharedPref.kUserName,
      email: KeySharedPref.kUserEmail,
      password: KeySharedPref.kUserPassword,
      role: KeySharedPref.kUserRole,
      avatarUrl: KeySharedPref.kUserAvatarUrl,
      bio: KeySharedPref.kBio,
      numberBank: int.tryParse(KeySharedPref.kNumberBank),
      nameBank: KeySharedPref.kNameBank,
      specialization: KeySharedPref.kSpecialization,
      isAvailable: int.tryParse(KeySharedPref.kIsAvailable),
      averageRating: double.tryParse(KeySharedPref.kAverageRating),
      reviewsCount: int.tryParse(KeySharedPref.kReviewsCount),
      totalOrders: int.tryParse(KeySharedPref.kTotalOrders),
      worksCount: int.tryParse(KeySharedPref.kWorksCount),
    );
  }

  @override
  Future<Unit> updateData(DesignerModel designer) async {
    var json = designer.toJson();
    await sharedPreferences.setString(
        KeySharedPref.kUserId, json[KeySharedPref.kUserId]);
    await sharedPreferences.setString(
        KeySharedPref.kUserName, json[KeySharedPref.kUserName]);
    await sharedPreferences.setString(
        KeySharedPref.kUserEmail, json[KeySharedPref.kUserEmail]);
    await sharedPreferences.setString(
        KeySharedPref.kUserPassword, json[KeySharedPref.kUserPassword]);
    await sharedPreferences.setString(
        KeySharedPref.kUserRole, json[KeySharedPref.kUserRole]);
    await sharedPreferences.setString(
        KeySharedPref.kUserAvatarUrl, json[KeySharedPref.kUserAvatarUrl]);
    await sharedPreferences.setString(
        KeySharedPref.kBio, json[KeySharedPref.kBio]);
    await sharedPreferences.setString(
        KeySharedPref.kNumberBank, json[KeySharedPref.kNumberBank]);
    await sharedPreferences.setString(
        KeySharedPref.kNameBank, json[KeySharedPref.kNameBank]);
    await sharedPreferences.setString(
        KeySharedPref.kSpecialization, json[KeySharedPref.kSpecialization]);
    await sharedPreferences.setString(
        KeySharedPref.kIsAvailable, json[KeySharedPref.kIsAvailable]);
    await sharedPreferences.setString(
        KeySharedPref.kAverageRating, json[KeySharedPref.kAverageRating]);
    await sharedPreferences.setString(
        KeySharedPref.kReviewsCount, json[KeySharedPref.kReviewsCount]);
    await sharedPreferences.setString(
        KeySharedPref.kTotalOrders, json[KeySharedPref.kTotalOrders]);
    await sharedPreferences.setString(
        KeySharedPref.kWorksCount, json[KeySharedPref.kWorksCount]);
    return unit;
  }
}

// class DesignerLocalDataSourceImpBySql implements DesignerLocalDataSource {
//   final SQLHelper sqlHelper;
//
//   DesignerLocalDataSourceImpBySql({required this.sqlHelper});
//   @override
//   Future<DesignerModel> getData(String id) async {
//     final db = await sqlHelper.openDB();
//     final maps = await db.query(
//       'Users',
//       where: 'id = ?',
//       whereArgs: [id],
//     );
//     if (maps.isNotEmpty) return DesignerModel.fromJson(maps.first);
//     throw EmptyLocalDatabaseException();
//   }
//
//   @override
//   Future<Unit> updateData(DesignerModel designer) async {
//     final db = await sqlHelper.openDB();
//
//     int response = await db.update("Users", designer.toJson(),
//         where: "id = ?", whereArgs: [designer.id]);
//     debugPrint("Update is : ${response == 1 ? 'Done' : 'Failed'}");
//     return unit;
//   }
//
//   @override
//   Future<Unit> deleteData(String id) async {
//     final db = await sqlHelper.openDB();
//
//     int response = await db.delete("Users", where: "id = ?", whereArgs: [id]);
//     debugPrint("Delete is : ${response == 1 ? 'Done' : 'Failed'}");
//     return unit;
//   }
// }
