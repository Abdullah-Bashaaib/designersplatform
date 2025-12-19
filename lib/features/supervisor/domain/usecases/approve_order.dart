import 'package:dartz/dartz.dart';
import 'package:designers_platform/core/error/failures.dart';
import 'package:designers_platform/features/supervisor/domain/repositories/supervisor_repository.dart';

class ApproveOrderUseCase {
  final SupervisorRepository repository;

  ApproveOrderUseCase(this.repository);

  Future<Either<Failure, void>> call(String orderId) {
    return repository.approveOrder(orderId);
  }
}
