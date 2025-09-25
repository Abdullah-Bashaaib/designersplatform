import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:designers_platform/core/current_user.dart';
import 'package:designers_platform/core/error/exception.dart';
import 'package:designers_platform/core/service/firebase_service.dart';
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
  // final Database _db;
  final FirebaseFirestore _firestore;

  RemoteDataSource(this._firestore);

  @override
  Future<User?> checkAccountInRemote(String email, String password) async {
    try {
      final result = await _firestore
          .collection('Users')
          .where('email', isEqualTo: email)
          .where('password', isEqualTo: password)
          .get();
      if (result.docs.isNotEmpty) {
        return UserModel.fromJson(result as Map<String, dynamic>);
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
      await _firestore
          .collection('Users')
          .doc(userModel.id)
          .set(userModel.toMap());
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
