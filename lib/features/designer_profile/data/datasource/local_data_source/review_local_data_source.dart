import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:designers_platform/features/designer_profile/data/models/reivew_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/utils/key_app.dart';

abstract class ReviewLocalDataSource {
  Future<List<ReviewModel>> getData(String designerId);
  Future<Unit> addReview(ReviewModel review);
  Future<Unit> updateReview(ReviewModel review);
  Future<Unit> deleteReview(String id);
}

class ReviewLocalDataSourceImpBySql implements ReviewLocalDataSource {
  final SharedPreferences sharedPreferences;
  ReviewLocalDataSourceImpBySql({required this.sharedPreferences});

  @override
  Future<List<ReviewModel>> getData(String designerId) async {
    final reviewsPref = sharedPreferences.getString(KeySharedPref.reviewKey);
    if (reviewsPref == null) return [];

    final List<dynamic> jsonList = jsonDecode(reviewsPref);
    return jsonList
        .where((r) => r['designerId'] == designerId)
        .map((r) => ReviewModel(
              id: r['id'],
              designerId: r['designer_id'],
              clientId: r['client_id'],
              orderId: r['order_id'],
              timeReview: r['time_review'],
              nameClint: r['name_clint'],
              valueReview: r['value_review'],
            ))
        .toList();
  }

  @override
  Future<Unit> addReview(ReviewModel review) async {
    // نجيب القائمة من SharedPreferences
    final reviewsPref = sharedPreferences.getString(KeySharedPref.reviewKey);

    // إذا ما في قائمة مسبقة → نبدأ بقائمة فاضية
    List<Map<String, dynamic>> reviewsList = [];

    if (reviewsPref != null) {
      final List<dynamic> reviewsJson = jsonDecode(reviewsPref);
      reviewsList = reviewsJson.cast<Map<String, dynamic>>();
    }

    // تحقق إذا المراجعة موجودة بنفس id
    final exists = reviewsList.any((item) => item['id'] == review.id);
    if (exists) {
      // لو موجودة، ما نضيفها
      return unit;
    }

    // نضيف المراجعة الجديدة
    reviewsList.add({
      "id": review.id,
      "designerId": review.designerId,
      "clientId": review.clientId,
      "orderId": review.orderId,
      "timeReview": review.timeReview,
      "nameClint": review.nameClint,
    });

    // نخزن القائمة كاملة من جديد
    await sharedPreferences.setString(
      KeySharedPref.reviewKey,
      jsonEncode(reviewsList),
    );

    return unit;
  }

  @override
  Future<Unit> updateReview(ReviewModel review) async {
    final reviewsPref = sharedPreferences.getString(KeySharedPref.reviewKey);

    if (reviewsPref == null) {
      // ما في أي مراجعات محفوظة
      return unit;
    }

    // نفك JSON إلى List
    final List<dynamic> reviewsJson = jsonDecode(reviewsPref);

    // نحول الـ List إلى List من Map
    final List<Map<String, dynamic>> reviewsList =
        reviewsJson.cast<Map<String, dynamic>>();

    // نبحث عن المراجعة حسب الـ id
    final index = reviewsList.indexWhere(
      (item) => item['id'] == review.id, // هنا عدلت
    );

    if (index == -1) {
      // ما لقيت Review بهذا id
      return unit;
    }

    // نستبدل المراجعة القديمة بالحديثة
    reviewsList[index] = {
      "id": review.id,
      "designerId": review.designerId,
      "clientId": review.clientId,
      "orderId": review.orderId,
      "timeReview": review.timeReview,
      "nameClint": review.nameClint,
    };

    // نخزن من جديد في SharedPreferences
    await sharedPreferences.setString(
      KeySharedPref.reviewKey,
      jsonEncode(reviewsList),
    );

    return unit;
  }

  @override
  Future<Unit> deleteReview(String id) async {
    final reviewsPref = sharedPreferences.getString(KeySharedPref.reviewKey);

    if (reviewsPref == null) {
      // ما في أي مراجعات محفوظة
      return unit;
    }

    // نفك JSON إلى List
    final List<dynamic> reviewsJson = jsonDecode(reviewsPref);

    // نحول الـ List إلى List من Map
    final List<Map<String, dynamic>> reviewsList =
        reviewsJson.cast<Map<String, dynamic>>();

    // نحذف المراجعة حسب id
    reviewsList.removeWhere((item) => item['id'] == id);

    // نخزن من جديد القائمة بعد الحذف
    await sharedPreferences.setString(
      KeySharedPref.reviewKey,
      jsonEncode(reviewsList),
    );

    return unit;
  }
}
