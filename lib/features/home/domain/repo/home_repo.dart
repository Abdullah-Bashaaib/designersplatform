import 'package:dartz/dartz.dart';
import 'package:designers_platform/core/error/failures.dart';
import 'package:designers_platform/features/designer_profile/domain/entities/designer.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<Designer>>> getDesigners(
      {int limit = 10, Designer? startAfter});
}
