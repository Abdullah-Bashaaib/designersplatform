import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:designers_platform/core/error/exception.dart';
import 'package:designers_platform/core/network/network_info.dart';
import 'package:designers_platform/features/auth/data/datasources/local_data.dart';
import 'package:designers_platform/features/auth/data/datasources/remote_data.dart';
import 'package:designers_platform/features/auth/domain/entities/user.dart';
import 'package:designers_platform/features/auth/domain/repositories/auth_repository.dart';

import '../../../../core/error/failures.dart';

class AuthRepositoryImp implements AuthRepository {
  final NetworkInfo networkInfo;
  final RemoteData remoteData;
  final LocalData localData;

  AuthRepositoryImp(this.networkInfo, this.remoteData, this.localData);

  @override
  Future<Either<Failure, User>> login(String email, String password) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteData.checkAccountInRemote(email, password);
        await localData.saveUser(result!);
        return Right(result);
      } on ServerException catch (e) {
        return left(NoUserFailure(e.message.toString()));
      }
    } else {
      return left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, User>> signUp(User user) async {
    if (await networkInfo.isConnected) {
      try {
        final result = user;
        await remoteData.signUp(user);
        await localData.saveUser(user);
        return Right(result);
      } on ServerException catch (e) {
        return left(ServerFailure(e.message.toString()));
      }
    } else {
      return left(OfflineFailure());
    }
  }

  @override
  bool isLoggedIn() {
    return localData.isLoggedIn();
  }

  @override
  void logout() {
    localData.logout();
  }

  @override
  Either<Failure, User> getUser() {
    final result = localData.getUser();
    if (result != null) {
      return right(result);
    } else {
      return left(NoUserFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteAccount() async {
    if (await networkInfo.isConnected) {
      await remoteData.deleteAccount();
      return right(unit);
    } else {
      return left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, String>> addAvatar(
      String userId, String filePath) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteData.addAvatar();
        return right(result);
      } on ServerException catch (e) {
        return left(ServerFailure(e.message.toString()));
      }
    } else {
      return left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> forgetPassword(String email) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteData.forgetPassword(email);
        return right(unit);
      } on ServerException {
        return left(ServerFailure(e.toString()));
      }
    } else {
      return left(OfflineFailure());
    }
  }
}
