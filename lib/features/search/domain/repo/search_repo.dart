import 'package:dartz/dartz.dart';
import 'package:designers_platform/core/error/failures.dart';
import 'package:designers_platform/features/designer_profile/domain/entities/designer.dart';

abstract class SearchRepo {
  Future<Either<Failure, List<Designer>>> searchDesigners(String query);
  Future<Either<Failure, List<Map<String, dynamic>>>> searchDesigns(
      String query);
}
