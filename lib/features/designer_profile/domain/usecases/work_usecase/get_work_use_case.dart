import 'package:dartz/dartz.dart';
import 'package:designers_platform/core/error/failures.dart';
import 'package:designers_platform/features/designer_profile/domain/entities/work.dart';
import 'package:designers_platform/features/designer_profile/domain/repositories/work_repository.dart';

class GetWorkUseCase {
  final WorkRepository workRepository;

  GetWorkUseCase({required this.workRepository});

  Future<Either<Failure, List<Work>>> call(String designerId) async {
    return await workRepository.getWork(designerId);
  }
}
