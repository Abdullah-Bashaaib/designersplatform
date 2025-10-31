import 'package:dartz/dartz.dart';
import 'package:designers_platform/core/error/failures.dart';
import 'package:designers_platform/features/order_management/domain/repo/order_repo.dart';

class UpdateOrderUsecase {
  final OrderRepo repo;

  UpdateOrderUsecase(this.repo);

  Future<Either<Failure, Unit>> updateOrder(
      String type, String description) async {
    return await repo.updateOrder(type, description);
  }
}
