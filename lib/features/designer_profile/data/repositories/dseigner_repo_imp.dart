import 'package:dartz/dartz.dart';
import 'package:designers_platform/core/error/failures.dart';
import 'package:designers_platform/features/auth/data/datasources/remote_data.dart';
import 'package:designers_platform/features/designer_profile/data/datasource/local_data_sorce.dart';
import 'package:designers_platform/features/designer_profile/domain/entities/designer.dart';
import 'package:designers_platform/features/designer_profile/domain/repositories/designer_repository.dart';

class DesignerRepoImp implements DesignerRepository {
  final LocalDataSource localDataSource;
  final RemoteDataSource remoteDataSource;

  DesignerRepoImp(this.localDataSource, this.remoteDataSource);

  @override
  Future<Either<Failure, Designer>> getDesigner(String id) {
    // TODO: implement getDesigner
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> updateProfile(Designer designer) {
    // TODO: implement updateProfile
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> deleteProfile(String id) {
    // TODO: implement deleteProfile
    throw UnimplementedError();
  }
}
