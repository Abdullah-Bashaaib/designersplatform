import 'package:dartz/dartz.dart';
import 'package:designers_platform/core/domain/i_internet_info.dart';
import 'package:designers_platform/core/error/exception.dart';
import 'package:designers_platform/core/error/failures.dart';
import 'package:designers_platform/features/designer_profile/data/datasource/remote_data_source/review_remote.dart';
import 'package:designers_platform/features/designer_profile/data/models/reivew_model.dart';
import 'package:designers_platform/features/designer_profile/domain/entities/review.dart';
import 'package:designers_platform/features/designer_profile/domain/repositories/review_repository.dart';

import '../datasource/local_data_source/review_local_data_source.dart';

class ReviewRepoImp implements ReviewRepository {
  final ReviewLocalDataSource localDataSource;
  final ReviewRemote remote;
  final INetworkInfo networkInfo;

  ReviewRepoImp(this.localDataSource, this.remote, this.networkInfo);

  @override
  Future<Either<Failure, List<Review>>> getReview() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remote.getReview();
        return Right(response);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> addReview(Review review) async {
    if (await networkInfo.isConnected) {
      try {
        final reviewModel = ReviewModel(
          id: review.id,
          clientId: review.clientId,
          designerId: review.designerId,
          nameClint: review.nameClint,
          orderId: review.orderId,
          timeReview: review.timeReview,
          valueReview: review.valueReview,
        );
        await remote.addReview(reviewModel);
        return Right(unit);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateReview(Review review) async {
    if (await networkInfo.isConnected) {
      try {
        final response =
            await localDataSource.updateReview(review as ReviewModel);
        return Right(response);
      } on EmptyLocalDatabaseException {
        return Left(EmptyLocalDatabaseFailure());
      }
    } else {
      return left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteReview(String id) async {
    if (await networkInfo.isConnected) {
      try {
        await localDataSource.deleteReview(id);
        return Right(unit);
      } on EmptyLocalDatabaseException {
        return Left(EmptyLocalDatabaseFailure());
      }
    } else {
      return left(OfflineFailure());
    }
  }
}
