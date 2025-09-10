import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/work_model.dart';

abstract class WorkLocalDataSource {
  Future<List<WorkModel>?> getData(String designerId);
  Future<Unit> addReview(WorkModel workModel);
  Future<Unit> updateReview(WorkModel workModel);
  Future<Unit> deleteReview(String id);
}

class WorkRemoteDataSourceImpBySql implements WorkLocalDataSource {
  final Database _db;
  WorkRemoteDataSourceImpBySql(this._db);
  @override
  Future<List<WorkModel>?> getData(designerId) async {
    final maps = await _db
        .query("Works", where: "designerId = ?", whereArgs: [designerId]);
    if (maps.isNotEmpty) {
      return maps.map((e) => WorkModel.fromJson(e)).toList();
    }
    return null;
  }

  @override
  Future<Unit> addReview(WorkModel workModel) async {
    final response = await _db.insert("Works", workModel.toJson());
    debugPrint("Insert is : ${response == 1 ? 'Done' : 'Failed'}");
    return unit;
  }

  @override
  Future<Unit> updateReview(WorkModel workModel) async {
    final response = await _db.update("Works", workModel.toJson(),
        where: "id = ? ", whereArgs: [workModel.id]);
    debugPrint("Update is : ${response == 1 ? 'Done' : 'Failed'}");
    return unit;
  }

  @override
  Future<Unit> deleteReview(String id) async {
    final response =
        await _db.delete("Works", where: "id = ? ", whereArgs: [id]);
    debugPrint("Delete is : ${response == 1 ? 'Done' : 'Failed'}");
    return unit;
  }
}
