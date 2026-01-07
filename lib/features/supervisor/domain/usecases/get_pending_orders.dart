import 'package:dartz/dartz.dart';
import 'package:designers_platform/core/error/failures.dart';
import 'package:designers_platform/features/order_management/domain/entity/orders.dart';
import 'package:designers_platform/features/supervisor/domain/repositories/supervisor_repository.dart';

class GetPendingOrdersUseCase {
  final SupervisorRepository repository;

  GetPendingOrdersUseCase(this.repository);

  Future<Either<Failure, List<OrderEntity>>> call() {
    return repository.getPendingOrders();
  }
}
