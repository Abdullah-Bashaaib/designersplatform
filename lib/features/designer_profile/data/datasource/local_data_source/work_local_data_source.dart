import 'package:dartz/dartz.dart';
import 'package:designers_platform/core/error/exception.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../core/database/sqflite_helper.dart';
import '../../models/work_model.dart';

abstract class WorkLocalDataSource {
  Future<List<WorkModel>> getData(String designerId);
  Future<Unit> addReview(WorkModel workModel);
  Future<Unit> updateReview(WorkModel workModel);
  Future<Unit> deleteReview(String id);
}

class WorkLocalDataSourceImpBySql implements WorkLocalDataSource {
  final SQLHelper sqlHelper;
  WorkLocalDataSourceImpBySql({required this.sqlHelper});
  @override
  Future<List<WorkModel>> getData(designerId) async {
    final db = await sqlHelper.openDB();
    final maps = await db
        .query("Works", where: "designerId = ?", whereArgs: [designerId]);
    if (maps.isNotEmpty) {
      return maps.map((e) => WorkModel.fromJson(e)).toList();
    }
    throw EmptyLocalDatabaseException();
  }

  @override
  Future<Unit> addReview(WorkModel workModel) async {
    final db = await sqlHelper.openDB();
    final response = await db.insert("Works", workModel.toJson());
    debugPrint("Insert is : ${response == 1 ? 'Done' : 'Failed'}");
    return unit;
  }

  @override
  Future<Unit> updateReview(WorkModel workModel) async {
    final db = await sqlHelper.openDB();
    final response = await db.update("Works", workModel.toJson(),
        where: "id = ? ", whereArgs: [workModel.id]);
    debugPrint("Update is : ${response == 1 ? 'Done' : 'Failed'}");
    return unit;
  }

  @override
  Future<Unit> deleteReview(String id) async {
    final db = await sqlHelper.openDB();
    final response =
        await db.delete("Works", where: "id = ? ", whereArgs: [id]);
    debugPrint("Delete is : ${response == 1 ? 'Done' : 'Failed'}");
    return unit;
  }
}
