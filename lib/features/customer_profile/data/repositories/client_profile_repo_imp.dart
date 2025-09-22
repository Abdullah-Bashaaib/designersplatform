import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:designers_platform/core/error/exception.dart';
import 'package:designers_platform/core/error/failures.dart';
import 'package:designers_platform/core/network/network_info.dart';
import 'package:designers_platform/core/usecase/get_user.dart';
import 'package:designers_platform/core/utils/messages.dart';
import 'package:designers_platform/features/auth/domain/entities/user.dart';
import 'package:designers_platform/features/auth/domain/repositories/auth_repository.dart';
import 'package:designers_platform/features/customer_profile/data/data_source/local_data_source.dart';
import 'package:designers_platform/features/customer_profile/domain/entities/client.dart';
import 'package:designers_platform/features/customer_profile/domain/entities/order_entity.dart';
import 'package:designers_platform/features/customer_profile/domain/repositories/client_profile_repo.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

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
  Future<Either<Failure, Unit>> deleteProfile() async {
    if (await networkInfo.isConnected) {
      try {
        await localDataSource.deleteProfile();
        return right(unit);
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      return left(OfflineFailure());
    }
  }

  @override
  Either<Failure, Client> getProfile() {
    try {
      final result = localDataSource.getProfile();
      if (result != null) {
        return right(result);
      } else {
        return left(NoUserFailure());
      }
    } on LocalException {
      return left(LocalFailure());
    }
  }

  @override
  Future<Either<Failure, List<User>>> getFavoritesList() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getFavoritesList();
        if (result.isNotEmpty) {
          return right(result);
        } else {
          return left(NoDataFailure(emptyFavoritesListMessage));
        }
      } on ServerException catch (e) {
        return left(ServerFailure(e.message.toString()));
      }
    } else {
      return left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, List<OrderEntity>>> getOrders() {
    // TODO: implement getOrders
    throw UnimplementedError();
  }
}
