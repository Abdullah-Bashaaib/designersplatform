import 'package:dartz/dartz.dart';
import 'package:designers_platform/core/error/exception.dart';
import 'package:designers_platform/core/error/failures.dart';
import 'package:designers_platform/core/network/network_info.dart';
import 'package:designers_platform/features/customer_profile/data/data_source/local_data_source.dart';
import 'package:designers_platform/features/customer_profile/domain/entities/client.dart';
import 'package:designers_platform/features/customer_profile/domain/repositories/client_profile_repo.dart';

import '../data_source/remote_data_source.dart';

class ClientProfileRepoImp implements ClientProfileRepo {
  final ClientRemoteDataSource remoteDataSource;
  final ClientLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ClientProfileRepoImp(
      this.remoteDataSource, this.localDataSource, this.networkInfo);
  @override
  Future<Either<Failure, Unit>> updateProfile(Client client) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.updateProfile(client);
        await localDataSource.updateProfile(client);
        return right(unit);
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      try {
        await localDataSource.updateProfile(client);
        return right(unit);
      } on LocalException {
        return left(LocalFailure());
      }
    }
  }
  
  @override
  Future<Either<Failure, String>> getAvatar(String userId, String filePath) {
    throw UnimplementedError();
  }
  
  @override
  Future<Either<Failure, Unit>> updateAvatar(String userId, String filePath) {
    // TODO: implement updateAvatar
    throw UnimplementedError();
  }
  
  @override
  Future<Either<Failure, Unit>> updatePassword(String userId, String password) {
    // TODO: implement updatePassword
    throw UnimplementedError();
  }
}
