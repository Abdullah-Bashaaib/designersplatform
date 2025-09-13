import 'package:dartz/dartz.dart';
import 'package:designers_platform/core/error/exception.dart';
import 'package:designers_platform/core/error/failures.dart';
import 'package:designers_platform/features/designer_profile/data/models/reivew_model.dart';
import 'package:designers_platform/features/designer_profile/domain/entities/review.dart';
import 'package:designers_platform/features/designer_profile/domain/repositories/review_repository.dart';

import '../../../auth/data/datasources/remote_data.dart';
import '../datasource/local_data_source/review_local_data_source.dart';

class ReviewRepoImp implements ReviewRepository {
  final ReviewLocalDataSource localDataSource;
  final RemoteDataSource remoteDataSource;
  ReviewRepoImp(this.localDataSource, this.remoteDataSource);

  @override
  Future<Either<Failure, List<Review>>> getReview(String designerId) async {
    try {
      List<ReviewModel> response = await localDataSource.getData(designerId);
      return Right(response);
    } on EmptyLocalDatabaseException {
      return Left(EmptyLocalDatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> addReview(Review review) async {
    try {
      final response = await localDataSource.addReview(review as ReviewModel);
      return Right(response);
    } on EmptyLocalDatabaseException {
      return Left(EmptyLocalDatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateReview(Review review) async {
    try {
      final response =
          await localDataSource.updateReview(review as ReviewModel);
      return Right(response);
    } on EmptyLocalDatabaseException {
      return Left(EmptyLocalDatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteReview(String id) async {
    try {
      await localDataSource.deleteReview(id);
      return Right(unit);
    } on EmptyLocalDatabaseException {
      return Left(EmptyLocalDatabaseFailure());
    }
  }
}
