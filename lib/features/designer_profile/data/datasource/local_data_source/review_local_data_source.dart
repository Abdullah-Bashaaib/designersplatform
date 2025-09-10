import 'package:dartz/dartz.dart';
import 'package:designers_platform/features/designer_profile/data/models/reivew_model.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

abstract class ReviewLocalDataSource {
  Future<List<ReviewModel>?> getData(String designerId);
  Future<Unit> addReview(ReviewModel review);
  Future<Unit> updateReview(ReviewModel review);
  Future<Unit> deleteReview(String id);
}

class ReviewRemoteDataSourceImpBySql implements ReviewLocalDataSource {
  final Database _db;
  ReviewRemoteDataSourceImpBySql(this._db);
  @override
  Future<List<ReviewModel>?> getData(String designerId) async {
    final json = await _db
        .query("Reviews", where: "designerId = ?", whereArgs: [designerId]);
    if (json.isNotEmpty) {
      return json.map((e) => ReviewModel.fromJson(e)).toList();
    }
    return null;
  }

  @override
  Future<Unit> addReview(ReviewModel review) async {
    final response = await _db.insert("Reviews", review.toJson());
    debugPrint("Insert is : ${response == 1 ? 'Done' : 'Failed'}");
    return unit;
  }

  @override
  Future<Unit> updateReview(ReviewModel review) async {
    final response = await _db.update("Reviews", review.toJson(),
        where: "designerId = ? ", whereArgs: [review.designerId]);
    debugPrint("Update is : ${response == 1 ? 'Done' : 'Failed'}");
    return unit;
  }

  @override
  Future<Unit> deleteReview(String id) async {
    final response =
        await _db.delete("Reviews", where: "id = ? ", whereArgs: [id]);
    debugPrint("Delete is : ${response == 1 ? 'Done' : 'Failed'}");
    return unit;
  }
}
