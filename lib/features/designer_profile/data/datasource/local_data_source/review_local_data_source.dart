import 'package:dartz/dartz.dart';
import 'package:designers_platform/core/error/exception.dart';
import 'package:designers_platform/features/designer_profile/data/models/reivew_model.dart';
import 'package:flutter/foundation.dart';

import '../../../../../core/database/sqflite_helper.dart';

abstract class ReviewLocalDataSource {
  Future<List<ReviewModel>> getData(String designerId);
  Future<Unit> addReview(ReviewModel review);
  Future<Unit> updateReview(ReviewModel review);
  Future<Unit> deleteReview(String id);
}

class ReviewLocalDataSourceImpBySql implements ReviewLocalDataSource {
  final SQLHelper sqlHelper;
  ReviewLocalDataSourceImpBySql({required this.sqlHelper});
  @override
  Future<List<ReviewModel>> getData(String designerId) async {
    final db = await sqlHelper.openDB();

    final json = await db
        .query("Reviews", where: "designerId = ?", whereArgs: [designerId]);
    if (json.isNotEmpty) {
      return json.map((e) => ReviewModel.fromJson(e)).toList();
    }
    throw EmptyLocalDatabaseException();
  }

  @override
  Future<Unit> addReview(ReviewModel review) async {
    final db = await sqlHelper.openDB();
    final response = await db.insert("Reviews", review.toJson());
    debugPrint("Insert is : ${response == 1 ? 'Done' : 'Failed'}");
    return unit;
  }

  @override
  Future<Unit> updateReview(ReviewModel review) async {
    final db = await sqlHelper.openDB();
    final response = await db.update("Reviews", review.toJson(),
        where: "designerId = ? ", whereArgs: [review.designerId]);
    debugPrint("Update is : ${response == 1 ? 'Done' : 'Failed'}");
    return unit;
  }

  @override
  Future<Unit> deleteReview(String id) async {
    final db = await sqlHelper.openDB();
    final response =
        await db.delete("Reviews", where: "id = ? ", whereArgs: [id]);
    debugPrint("Delete is : ${response == 1 ? 'Done' : 'Failed'}");
    return unit;
  }
}
