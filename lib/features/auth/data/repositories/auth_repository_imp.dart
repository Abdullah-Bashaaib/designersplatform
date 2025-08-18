import 'package:dartz/dartz.dart';
import 'package:designers_platform/core/error/exception.dart';
import 'package:designers_platform/core/network/network_info.dart';
import 'package:designers_platform/features/auth/data/datasources/remote_data.dart';
import 'package:designers_platform/features/auth/domain/entities/user.dart';
import 'package:designers_platform/features/auth/domain/repositories/auth_repository.dart';

import '../../../../core/error/failures.dart';

class AuthRepositoryImp implements AuthRepository {
  final NetworkInfo networkInfo;
  final RemoteDataSource remoteDataSource;

  AuthRepositoryImp(this.networkInfo, this.remoteDataSource);
  @override
  Future<Either<Failure, User>> login(String email, String password) async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await remoteDataSource.checkAccountInRemote(email, password);
        return Right(result);
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      return left(ServerFailure());
    }
  }
}
