import 'package:dartz/dartz.dart';
import 'package:designers_platform/core/error/failures.dart';
import 'package:designers_platform/features/supervisor/domain/repositories/supervisor_repository.dart';

class UpdateSupervisorProfileUseCase {
  final SupervisorRepository repository;

  UpdateSupervisorProfileUseCase(this.repository);

  Future<Either<Failure, void>> call(String userId, Map<String, dynamic> data) {
    return repository.updateSupervisorProfile(userId, data);
  }
}
