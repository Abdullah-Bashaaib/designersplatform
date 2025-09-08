import 'package:dartz/dartz.dart';
import 'package:designers_platform/core/error/failures.dart';
import 'package:designers_platform/features/designer_profile/domain/entities/designer.dart';

abstract class ProfileRepository {
  Future<Either<Failure, Unit>> updateProfile(Designer designer);
}
