import 'package:dartz/dartz.dart';
import 'package:designers_platform/core/error/exception.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/designer_model.dart';

abstract class DesignerLocalDataSource {
  Future<DesignerModel> getData(String id);
  Future<Unit> updateData(DesignerModel designer);
  Future<Unit> deleteData(String id);
}

class DesignerLocalDataSourceImpBySql implements DesignerLocalDataSource {
  final Database _db;

  DesignerLocalDataSourceImpBySql(this._db);
  @override
  Future<DesignerModel> getData(String id) async {
    final maps = await _db.query(
      'Users',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) return DesignerModel.fromJson(maps.first);
    throw EmptyLocalDatabaseException();
  }

  @override
  Future<Unit> updateData(DesignerModel designer) async {
    int response = await _db.update("Users", designer.toJson(),
        where: "id = ?", whereArgs: [designer.user.id]);
    debugPrint("Update is : ${response == 1 ? 'Done' : 'Failed'}");
    return unit;
  }

  @override
  Future<Unit> deleteData(String id) async {
    int response = await _db.delete("Users", where: "id = ?", whereArgs: [id]);
    debugPrint("Delete is : ${response == 1 ? 'Done' : 'Failed'}");
    return unit;
  }
}
