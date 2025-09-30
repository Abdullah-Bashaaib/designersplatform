import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:designers_platform/core/current_user.dart';
import 'package:designers_platform/core/error/exception.dart'
    hide FirebaseException;
import 'package:designers_platform/features/auth/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User, FirebaseException;

import '../../../../core/error/firebase_error.dart';
import '../../domain/entities/user.dart';

abstract class RemoteData {
  Future<User?> checkAccountInRemote(String email, String password);
  Future<User> signUp(User user, String password);
  Future<void> deleteAccount();
  Future<String> addAvatar();
  Future<bool> forgetPassword(String email);
}

class RemoteDataSource implements RemoteData {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  RemoteDataSource(this._firestore);

  @override
  Future<User?> checkAccountInRemote(String email, String password) async {
    try {
      final loginUser = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      if (!loginUser.user!.emailVerified) {
        await loginUser.user!.sendEmailVerification();
      }
      final result = await _firestore
          .collection('Users')
          .where('email', isEqualTo: loginUser.user!.email)
          .get();
      if (result.docs.isEmpty) {
        return null;
      } else {
        return UserModel.fromJson(result.docs.first.data());
      }
    } on FirebaseAuthException catch (e) {
      throw ServerException(
        FirebaseAuthErrorHandler.getErrorMessage(e),
      );
    } catch (e) {
      throw ServerException(e);
    }
  }

  @override
  Future<User> signUp(User user, String password) async {
    try {
      UserModel userModel = UserModel(
        id: user.id,
        name: user.name,
        email: user.email,
        role: user.role,
      );
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: userModel.email, password: password);
      await _firestore
          .collection('Users')
          .doc(userModel.id)
          .set(userModel.toMap());
      return user;
    } on FirebaseAuthException catch (e) {
      throw ServerException(
        FirebaseAuthErrorHandler.getErrorMessage(e),
      );
    } catch (e) {
      throw ServerException(e);
    }
  }

  @override
  Future<void> deleteAccount() async {
    try {
      // await _firebaseAuth.;
      await _firestore
          .collection('Users')
          .doc(CurrentUser.currentUser!.id)
          .delete();
    } on FirebaseAuthException catch (e) {
      throw ServerException(
        FirebaseAuthErrorHandler.getErrorMessage(e),
      );
    } catch (e) {
      throw ServerException(e);
    }
  }

  @override
  Future<String> addAvatar() {
    throw UnimplementedError();
  }

  @override
  Future<bool> forgetPassword(String email) async {
    try {
      final result = await FirebaseFirestore.instance
          .collection('Users')
          .where('email', isEqualTo: email)
          .get();
      if (result.docs.isNotEmpty) {
        await _firebaseAuth.sendPasswordResetEmail(email: email);
        return true;
      } else {
        return false;
      }
    } on FirebaseAuthException catch (e) {
      throw ServerException(
        FirebaseAuthErrorHandler.getErrorMessage(e),
      );
    } catch (e) {
      throw ServerException(e);
    }
  }
}
