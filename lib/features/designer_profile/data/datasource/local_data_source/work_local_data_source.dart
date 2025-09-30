import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/utils/key_app.dart';
import '../../models/work_model.dart';

abstract class WorkLocalDataSource {
  Future<List<WorkModel>> getData(String designerId);
  Future<Unit> addReview(WorkModel workModel);
  Future<Unit> updateReview(WorkModel workModel);
  Future<Unit> deleteReview(String id);
}

class WorkLocalDataSourceImpBySql implements WorkLocalDataSource {
  final SharedPreferences sharedPreferences;
  WorkLocalDataSourceImpBySql({required this.sharedPreferences});
  @override
  Future<List<WorkModel>> getData(designerId) async {
    final worksPref = sharedPreferences.getString(KeySharedPref.worksKey);
    if (worksPref == null) return [];

    final List<dynamic> worksJson = jsonDecode(worksPref);

    return worksJson
        .where((item) => item['designerId'] == designerId)
        .map((item) => WorkModel.fromJson(item))
        .toList();
  }

  @override
  Future<Unit> addReview(WorkModel work) async {
    final worksPref = sharedPreferences.getString(KeySharedPref.worksKey);

    List<Map<String, dynamic>> worksList = [];

    if (worksPref != null) {
      final List<dynamic> worksJson = jsonDecode(worksPref);
      worksList = worksJson.cast<Map<String, dynamic>>();
    }

    // تحقق إذا العمل موجود بنفس id
    final exists = worksList.any((item) => item['id'] == work.id);
    if (exists) return unit;

    worksList.add(work.toJson());

    await sharedPreferences.setString(
      KeySharedPref.worksKey,
      jsonEncode(worksList),
    );

    return unit;
  }

  @override
  Future<Unit> updateReview(WorkModel work) async {
    final worksPref = sharedPreferences.getString(KeySharedPref.worksKey);

    if (worksPref == null) return unit;

    final List<dynamic> worksJson = jsonDecode(worksPref);
    final List<Map<String, dynamic>> worksList =
        worksJson.cast<Map<String, dynamic>>();

    final index = worksList.indexWhere((item) => item['id'] == work.id);
    if (index == -1) return unit;

    worksList[index] = work.toJson();

    await sharedPreferences.setString(
      KeySharedPref.worksKey,
      jsonEncode(worksList),
    );

    return unit;
  }

  @override
  Future<Unit> deleteReview(String id) async {
    final worksPref = sharedPreferences.getString(KeySharedPref.worksKey);
    if (worksPref == null) return unit;

    final List<dynamic> worksJson = jsonDecode(worksPref);
    final List<Map<String, dynamic>> worksList =
        worksJson.cast<Map<String, dynamic>>();

    worksList.removeWhere((item) => item['id'] == id);

    await sharedPreferences.setString(
      KeySharedPref.worksKey,
      jsonEncode(worksList),
    );

    return unit;
  }
}
