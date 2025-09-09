import 'package:dartz/dartz.dart';
import 'package:designers_platform/core/error/failures.dart';
import 'package:designers_platform/features/designer_profile/domain/entities/designer.dart';

abstract class DesignerRepository {
  Future<Either<Failure, Designer>> getDesigner(String id);
  Future<Either<Failure, Unit>> updateProfile(Designer designer);
  Future<Either<Failure, Unit>> deleteProfile(String id);
}
