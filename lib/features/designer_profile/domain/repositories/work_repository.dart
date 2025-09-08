import 'package:dartz/dartz.dart';
import 'package:designers_platform/core/error/failures.dart';
import 'package:designers_platform/features/designer_profile/domain/entities/work.dart';

abstract class WorkRepository {
  Future<Either<Failure, List<Work>>> getWork(int designerId);
  Future<Either<Failure, Unit>> addWork(Work work);
  Future<Either<Failure, Unit>> updateWork(Work work);
  Future<Either<Failure, Unit>> deleteWork(int workId);
}
