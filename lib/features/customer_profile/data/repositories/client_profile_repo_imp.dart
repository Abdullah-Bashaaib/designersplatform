import 'package:dartz/dartz.dart';
import 'package:designers_platform/core/current_user.dart';
import 'package:designers_platform/core/error/exception.dart';
import 'package:designers_platform/core/error/failures.dart';
import 'package:designers_platform/core/utils/messages.dart';
import 'package:designers_platform/features/auth/domain/entities/user.dart';
import 'package:designers_platform/features/customer_profile/data/data_source/local_data_source.dart';
import 'package:designers_platform/features/customer_profile/domain/entities/client.dart';
import 'package:designers_platform/features/customer_profile/domain/repositories/client_profile_repo.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/domain/i_internet_info.dart';
import '../data_source/remote_data_source.dart';

class ClientProfileRepoImp implements ClientProfileRepo {
  final ClientRemoteDataSource remoteDataSource;
  final ClientLocalDataSource localDataSource;
  final INetworkInfo networkInfo;

  ClientProfileRepoImp(
      this.remoteDataSource, this.localDataSource, this.networkInfo);
  @override
  Future<Either<Failure, Unit>> updateUserName(String name) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.updateUserName(name);
        CurrentUser.currentUser?.copyWith(name: name);
        localDataSource.saveUser(CurrentUser.currentUser!);
        return right(unit);
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      try {
        // localDataSource.updateProfile(client);
        return right(unit);
      } on LocalException {
        return left(LocalFailure());
      }
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
  Future<Either<Failure, String>> addAvatar(XFile file) async {
    if (await networkInfo.isConnected) {
      try {
        final imageUrl = await remoteDataSource.addAvatar(file);
        CurrentUser.currentUser!.avatarUrl = imageUrl;
        localDataSource.saveUser(CurrentUser.currentUser!);
        return right(imageUrl);
      } on ServerException catch (e) {
        return left(ServerFailure(e.message.toString()));
      }
    } else {
      return left(OfflineFailure());
    }
  }

  @override
  Either<Failure, Unit> saveUser(User user) {
    try {
      localDataSource.saveUser(user);
      return right(unit);
    } on LocalException catch (e) {
      return left(LocalFailure(e.message.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteAvatar() async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deleteAvatar();
        CurrentUser.currentUser!.avatarUrl = '';
        localDataSource.saveUser(CurrentUser.currentUser!);
        return right(unit);
      } on ServerException catch (e) {
        return left(ServerFailure(e.message.toString()));
      }
    } else {
      return left(OfflineFailure());
    }
  }
}
