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
        return Right(result);
      } on ServerException {
        return left(NoUserFailure());
      }
    } else {
      return left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, User>> signUp(User user) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteData.signUp(user);
        await localData.saveUser(user);
        return Right(result);
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      return left(ServerFailure());
    }
  }

  @override
  Future<void> saveUser(User user) async {
    await localData.saveUser(user);
  }

  @override
  bool isLoggedIn() {
    return localData.isLoggedIn();
  }

  @override
  Future<void> clearUser() async {
    await localData.clearUser();
  }

  @override
  Future<User> getUser() async {
    return await localData.getUser();
  }

  @override
  Future<bool> deleteAccount() async {
    return await remoteData.deleteAccount();
  }
}
