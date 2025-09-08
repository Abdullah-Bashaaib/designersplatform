import 'package:dartz/dartz.dart';
import 'package:designers_platform/core/error/failures.dart';
import 'package:designers_platform/features/designer_profile/domain/entities/work.dart';
import 'package:designers_platform/features/designer_profile/domain/repositories/work_repository.dart';

class AddWorkUseCase {
  final WorkRepository workRepository;

  AddWorkUseCase({required this.workRepository});

  Future<Either<Failure, Unit>> call(Work work) async {
    return await workRepository.addWork(work);
  }
}
