import 'package:dartz/dartz.dart';
import 'package:designers_platform/core/error/failures.dart';
import 'package:designers_platform/features/designer_profile/domain/entities/work.dart';
import 'package:designers_platform/features/designer_profile/domain/repositories/work_repository.dart';

import '../../../auth/data/datasources/remote_data.dart';
import '../datasource/local_data_sorce.dart';

class WorkRepoImp implements WorkRepository {
  final LocalDataSource localDataSource;
  final RemoteDataSource remoteDataSource;
  WorkRepoImp(this.localDataSource, this.remoteDataSource);

  @override
  Future<Either<Failure, List<Work>>> getWork(String designerId) {
    // TODO: implement getWork
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> addWork(Work work) {
    // TODO: implement addWork
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> updateWork(Work work) {
    // TODO: implement updateWork
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> deleteWork(String workId) {
    // TODO: implement deleteWork
    throw UnimplementedError();
  }
}
