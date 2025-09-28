import 'dart:convert';

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
      id: '1',
      name: user.name,
      email: user.email,
      password: user.password,
      role: user.role,
    );
    final jsonString = jsonEncode(userModel.toMap());
    await perf.setString(KeySharedPref.userKey, jsonString);
    print(' ===== $jsonString =====');
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
