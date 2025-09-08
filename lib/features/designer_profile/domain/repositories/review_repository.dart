import 'package:dartz/dartz.dart';
import 'package:designers_platform/core/error/failures.dart';
import 'package:designers_platform/features/designer_profile/domain/entities/review.dart';

abstract class ReviewRepository {
  Future<Either<Failure, Review>> getReview(int designerId);
  Future<Either<Failure, Unit>> addReview(Review review);
  Future<Either<Failure, Unit>> updateReview(Review review);
  Future<Either<Failure, Unit>> deleteReview(int id);
}
