import 'package:dartz/dartz.dart';
import 'package:designers_platform/core/error/exception.dart';
import 'package:designers_platform/core/error/supabase_error_handler.dart';
import 'package:designers_platform/core/utils/app_functions.dart';
import 'package:designers_platform/core/utils/messages.dart';
import 'package:designers_platform/features/auth/data/datasources/local_data.dart';
import 'package:designers_platform/features/auth/data/datasources/remote_data.dart';
import 'package:designers_platform/features/auth/domain/entities/user.dart';
import 'package:designers_platform/features/auth/domain/repositories/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/domain/i_internet_info.dart';
import '../../../../core/error/failures.dart';

class AuthRepositoryImp implements AuthRepository {
  final INetworkInfo networkInfo;
  final RemoteData remoteData;
  final LocalData localData;

  AuthRepositoryImp(this.networkInfo, this.remoteData, this.localData);

  @override
  Future<Either<Failure, UserEntity>> login(
      String email, String password) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteData.checkAccountInRemote(email, password);
        if (result != null) {
          await localData.saveUser(result);
          return Right(result);
        } else {
          return left(NoUserFailure());
        }
      } on ServerException catch (e) {
        return left(ServerFailure(e.message.toString()));
      }
    } else {
      return left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signUp(
      UserEntity user, String password) async {
    if (await networkInfo.isConnected) {
      try {
        final newKeywords = [...AppFunctions.generateKeywords(user.name)];
        final newUser = user.copyWith(keywords: newKeywords);
        await remoteData.signUp(newUser, password);
        await localData.saveUser(newUser);
        return Right(newUser);
      } on AuthException catch (e) {
        return left(
            ServerFailure(SupabaseAuthErrorHandler.getErrorMessage(e.message)));
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
  Either<Failure, UserEntity> getUser() {
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
  Future<Either<Failure, Unit>> forgetPassword(String email) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteData.forgetPassword(email);
        if (result == true) {
          return right(unit);
        } else {
          return left(NoDataFailure(emptyEmailMessage));
        }
      } on ServerException catch (e) {
        return left(ServerFailure(e.message.toString()));
      }
    } else {
      return left(OfflineFailure());
    }
  }
}
