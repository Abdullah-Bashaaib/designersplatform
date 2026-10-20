import 'dart:convert';

import 'package:designers_platform/core/usecase/get_user.dart';
import 'package:designers_platform/core/utils/key_app.dart';
import 'package:designers_platform/features/auth/data/models/user_model.dart';
import 'package:designers_platform/features/auth/domain/entities/user.dart';
import 'package:designers_platform/features/auth/domain/repositories/auth_repository.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppFunctions {
  static List<String> generateKeywords(String text) {
    return text
        .trim()
        .toLowerCase()
        .split(RegExp(r'\s+')) // تقسيم على المسافات
        .toSet() // إزالة التكرار
        .toList();
  }

  static Future<UserEntity?> checkUser() async {
    try {
      final perf = await SharedPreferences.getInstance();
      final jsonString = perf.getString(KeySharedPref.userKey);
      if (jsonString != null) {
        final Map<String, dynamic> userMap = jsonDecode(jsonString);
        final user = UserModel.fromJson(userMap);
        return user;
      }
    } catch (e) {
      return null;
    }
  }
}
