import 'dart:convert';

import 'package:designers_platform/core/error/exception.dart';
import 'package:designers_platform/features/customer_profile/data/model/client_model.dart';
import 'package:designers_platform/features/customer_profile/domain/entities/client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/utils/key_app.dart';
import '../../../auth/data/models/user_model.dart';
import '../../../auth/domain/entities/user.dart';

abstract class ClientLocalDataSource {
  Client? getProfile();
  void saveUser(UserEntity user);
}

class ClientLocalDataSourceImp implements ClientLocalDataSource {
  final SharedPreferences perf;

  ClientLocalDataSourceImp(this.perf);

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
  void saveUser(UserEntity user) {
    try {
      final UserModel userModel = UserModel(
        id: user.id,
        name: user.name,
        email: user.email,
        phoneNumber: user.phoneNumber,
        role: user.role,
        avatarUrl: user.avatarUrl,
        keywords: user.keywords,
      );
      final jsonString = jsonEncode(userModel.toMap());
      perf.setString(KeySharedPref.userKey, jsonString);
    } catch (e) {
      throw LocalException();
    }
  }
}
