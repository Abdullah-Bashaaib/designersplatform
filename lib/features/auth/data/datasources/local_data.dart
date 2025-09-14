import 'dart:convert';

import 'package:designers_platform/core/utils/key_app.dart';
import 'package:designers_platform/features/auth/data/models/user_model.dart';
import 'package:designers_platform/features/auth/domain/entities/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalData {
  Future<void> saveUser(User user);
  Future<User> getUser();
  Future<void> clearUser();
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
  }

  @override
  bool isLoggedIn() {
    return perf.containsKey(KeySharedPref.userKey);
  }

  @override
  Future<void> clearUser() async {
    await perf.remove(KeySharedPref.userKey);
  }

  @override
  Future<User> getUser() {
    throw UnimplementedError();
  }
}
