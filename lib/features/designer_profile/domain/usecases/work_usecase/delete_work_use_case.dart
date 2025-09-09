import 'package:dartz/dartz.dart';
import 'package:designers_platform/core/error/failures.dart';
import 'package:designers_platform/features/designer_profile/domain/repositories/work_repository.dart';

class DeleteWorkUseCase {
  final WorkRepository workRepository;

  DeleteWorkUseCase({required this.workRepository});

  Future<Either<Failure, Unit>> call(String workId) async {
    return await workRepository.deleteWork(workId);
  }
}
