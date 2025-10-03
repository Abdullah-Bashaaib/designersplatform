import 'dart:convert';
import 'dart:developer';

import 'package:designers_platform/core/utils/key_app.dart';
import 'package:designers_platform/features/auth/data/models/user_model.dart';
import 'package:designers_platform/features/auth/domain/entities/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalData {
  Future<void> saveUser(User user);
  User? getUser();
  void logout();
  bool isLoggedIn();
}

class LocalDataImp implements LocalData {
  final SharedPreferences perf;

  LocalDataImp(this.perf);

  @override
  Future<void> saveUser(User user) async {
    UserModel userModel = UserModel(
      id: user.id,
      name: user.name,
      email: user.email,
      role: user.role,
      avatarUrl: user.avatarUrl,
    );
    await perf.setString(KeySharedPref.kUserId, user.id);
    log("There id added in Sheard Pref: ${user.id}");
    final jsonString = jsonEncode(userModel.toMap());
    await perf.setString(KeySharedPref.userKey, jsonString);
    log(' ===== $jsonString =====');
  }

  @override
  bool isLoggedIn() {
    return perf.containsKey(KeySharedPref.userKey);
  }

  @override
  void logout() {
    perf.clear();
  }

  @override
  User? getUser() {
    final jsonString = perf.getString(KeySharedPref.userKey);
    if (jsonString != null) {
      final Map<String, dynamic> userMap = jsonDecode(jsonString);
      return UserModel.fromJson(userMap);
    } else {
      return null;
    }
  }
}
