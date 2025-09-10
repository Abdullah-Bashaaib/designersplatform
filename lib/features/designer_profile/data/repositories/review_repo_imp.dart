import 'package:dartz/dartz.dart';
import 'package:designers_platform/core/error/failures.dart';
import 'package:designers_platform/features/designer_profile/domain/entities/review.dart';
import 'package:designers_platform/features/designer_profile/domain/repositories/review_repository.dart';

class ReviewRepoImp implements ReviewRepository {
  // final LocalDataSource localDataSource;
  // final RemoteDataSource remoteDataSource;
  // ReviewRepoImp(this.localDataSource, this.remoteDataSource);

  @override
  Future<Either<Failure, Review>> getReview(String designerId) {
    // TODO: implement getReview
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> addReview(Review review) {
    // TODO: implement addReview
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> updateReview(Review review) {
    // TODO: implement updateReview
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> deleteReview(String id) {
    // TODO: implement deleteReview
    throw UnimplementedError();
  }
}
