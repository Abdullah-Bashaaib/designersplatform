import 'package:designers_platform/core/current_user.dart';
import 'package:designers_platform/core/error/exception.dart';
import 'package:designers_platform/features/auth/data/models/user_model.dart';
import 'package:sqflite/sqflite.dart';

import '../../domain/entities/user.dart';

abstract class RemoteData {
  Future<User?> checkAccountInRemote(String email, String password);
  Future<User> signUp(User user);
  Future<bool> deleteAccount();
  Future<String> addAvatar();
}

class RemoteDataSource implements RemoteData {
  final Database _db;

  RemoteDataSource(this._db);

  @override
  Future<User?> checkAccountInRemote(String email, String password) async {
    try {
      final result = await _db.query('Users',
          where: 'email = ? AND password = ?', whereArgs: [email, password]);
      if (result.isNotEmpty) {
        return UserModel.fromJson(result.first);
      } else {
        return null;
      }
    } catch (e) {
      throw ServerException(e);
    }
  }

  @override
  Future<User> signUp(User user) async {
    try {
      UserModel userModel = UserModel(
        id: user.id,
        name: user.name,
        email: user.email,
        password: user.password,
        role: user.role,
      );
      await _db.insert('Users', userModel.toMap());
      return user;
    } catch (e) {
      throw ServerException(e);
    }
  }

  @override
  Future<bool> deleteAccount() {
    throw UnimplementedError();
  }

  @override
  Future<String> addAvatar() {
    throw UnimplementedError();
  }
}
