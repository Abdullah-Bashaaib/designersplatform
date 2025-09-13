import 'package:dartz/dartz.dart';
import 'package:designers_platform/core/database/sqflite_helper.dart';
import 'package:designers_platform/core/error/exception.dart';
import 'package:flutter/cupertino.dart';

import '../../models/designer_model.dart';

abstract class DesignerLocalDataSource {
  Future<DesignerModel> getData(String id);
  Future<Unit> updateData(DesignerModel designer);
  Future<Unit> deleteData(String id);
}

class DesignerLocalDataSourceImpBySql implements DesignerLocalDataSource {
  final SQLHelper sqlHelper;

  DesignerLocalDataSourceImpBySql({required this.sqlHelper});
  @override
  Future<DesignerModel> getData(String id) async {
    final db = await sqlHelper.openDB();
    final maps = await db.query(
      'Users',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) return DesignerModel.fromJson(maps.first);
    throw EmptyLocalDatabaseException();
  }

  @override
  Future<Unit> updateData(DesignerModel designer) async {
    final db = await sqlHelper.openDB();

    int response = await db.update("Users", designer.toJson(),
        where: "id = ?", whereArgs: [designer.id]);
    debugPrint("Update is : ${response == 1 ? 'Done' : 'Failed'}");
    return unit;
  }

  @override
  Future<Unit> deleteData(String id) async {
    final db = await sqlHelper.openDB();

    int response = await db.delete("Users", where: "id = ?", whereArgs: [id]);
    debugPrint("Delete is : ${response == 1 ? 'Done' : 'Failed'}");
    return unit;
  }
}
