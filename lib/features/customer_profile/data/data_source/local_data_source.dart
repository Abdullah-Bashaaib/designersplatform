import 'dart:convert';

import 'package:designers_platform/core/current_user.dart';
import 'package:designers_platform/core/error/exception.dart';
import 'package:designers_platform/features/customer_profile/data/model/client_model.dart';
import 'package:designers_platform/features/customer_profile/domain/entities/client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../core/utils/key_app.dart';
import '../../../auth/data/models/user_model.dart';
import '../../../auth/domain/entities/user.dart';

abstract class ClientLocalDataSource {
  Future<void> updateProfile(Client client);
  Client? getProfile();
  void saveUser(User user);
}

class ClientLocalDataSourceImp implements ClientLocalDataSource {
  final Database _db;
  final SharedPreferences perf;

  ClientLocalDataSourceImp(this._db, this.perf);

  @override
  Future<void> updateProfile(Client client) async {
    try {
      ClientModel clientModel = ClientModel();
      await _db.update('Users', clientModel.toMap());
    } catch (e) {
      throw LocalException();
    }
  }

  @override
  Client? getProfile() {
    final jsonString = perf.getString(KeySharedPref.userKey);
    if (jsonString != null) {
      final Map<String, dynamic> userMap = jsonDecode(jsonString);
      return ClientModel.fromJson(userMap);
    } else {
      return null;
    }
  }

  @override
  void saveUser(User user) {
    try {
      final UserModel userModel = UserModel(
        id: user.id,
        name: user.name,
        email: user.email,
        role: user.role,
        avatarUrl: user.avatarUrl,
      );
      final jsonString = jsonEncode(userModel.toMap());
      perf.setString(KeySharedPref.userKey, jsonString);
    } catch (e) {
      throw LocalException();
    }
  }
}
