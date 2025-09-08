import 'package:dartz/dartz.dart';
import 'package:designers_platform/core/error/failures.dart';
import 'package:designers_platform/features/designer_profile/domain/entities/work.dart';
import 'package:designers_platform/features/designer_profile/domain/repositories/work_repository.dart';

class UpdateWorkUseCase {
  final WorkRepository workRepository;

  UpdateWorkUseCase({required this.workRepository});

  Future<Either<Failure, Unit>> call(Work work) async {
    return await workRepository.updateWork(work);
  }
}
