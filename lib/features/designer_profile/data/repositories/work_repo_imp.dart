import 'package:dartz/dartz.dart';
import 'package:designers_platform/core/error/failures.dart';
import 'package:designers_platform/features/designer_profile/domain/entities/work.dart';
import 'package:designers_platform/features/designer_profile/domain/repositories/work_repository.dart';

import '../../../../core/error/exception.dart';
import '../datasource/local_data_source/work_local_data_source.dart';
import '../models/work_model.dart';

class WorkRepoImp implements WorkRepository {
  final WorkLocalDataSource localDataSource;
  WorkRepoImp(this.localDataSource);

  @override
  Future<Either<Failure, List<Work>>> getWork(String designerId) async {
    try {
      final response = await localDataSource.getData(designerId);
      return Right(response);
    } on EmptyLocalDatabaseException {
      return Left(EmptyLocalDatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> addWork(Work work) async {
    try {
      final response = await localDataSource.addReview(work as WorkModel);
      return Right(response);
    } on EmptyLocalDatabaseException {
      return Left(EmptyLocalDatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateWork(Work work) async {
    try {
      final response = await localDataSource.updateReview(work as WorkModel);
      return Right(response);
    } on EmptyLocalDatabaseException {
      return Left(EmptyLocalDatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteWork(String workId) async {
    try {
      final response = await localDataSource.deleteReview(workId);
      return Right(response);
    } on EmptyLocalDatabaseException {
      return Left(EmptyLocalDatabaseFailure());
    }
  }
}
