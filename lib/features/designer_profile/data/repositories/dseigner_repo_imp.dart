import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:designers_platform/core/error/failures.dart';
import 'package:designers_platform/features/designer_profile/data/datasource/local_data_source/designer_local_data_source.dart';
import 'package:designers_platform/features/designer_profile/data/models/designer_model.dart';
import 'package:designers_platform/features/designer_profile/domain/entities/designer.dart';
import 'package:designers_platform/features/designer_profile/domain/repositories/designer_repository.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/network/network_info.dart';
import '../datasource/remote_data_source/designer_remote_data_source.dart';

class DesignerRepoImp implements DesignerRepository {
  final DesignerLocalDataSource localDataSource;
  final DesignerRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  DesignerRepoImp(
      this.localDataSource, this.networkInfo, this.remoteDataSource);

  @override
  Future<Either<Failure, Designer>> getDesigner(String id) async {
    if (await networkInfo.isConnected) {
      try {
        log("----------------------------------> in DataSource imp user id : $id");

        final designer = await remoteDataSource.getData(id);
        if (designer == null) {
          try {
            final designer = await localDataSource.getData(id);
            return Right(designer!);
          } on EmptyLocalDatabaseException {
            return Left(EmptyLocalDatabaseFailure());
          }
        }
        return Right(designer);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
    try {
      final designer = await localDataSource.getData(id);
      return Right(designer!);
    } on EmptyLocalDatabaseException {
      return Left(EmptyLocalDatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateProfile(Designer designer) async {
    try {
      final designerM = DesignerModel.fromEntity(designer);
      await localDataSource.updateData(designerM);
      return Right(unit);
    } on EmptyLocalDatabaseException {
      return Left(EmptyLocalDatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteProfile(String id) async {
    try {
      await localDataSource.deleteData(id);
      return Right(unit);
    } on EmptyLocalDatabaseException {
      return Left(EmptyLocalDatabaseFailure());
    }
  }
}
