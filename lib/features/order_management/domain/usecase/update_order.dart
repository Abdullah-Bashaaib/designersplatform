import 'package:dartz/dartz.dart';
import 'package:designers_platform/core/error/failures.dart';
import 'package:designers_platform/features/order_management/domain/repo/order_repo.dart';

class UpdateOrderUsecase {
  final OrderRepo repo;

  UpdateOrderUsecase(this.repo);

  Future<Either<Failure, Unit>> call(
      String orderId, Map<String, dynamic> fields) async {
    return await repo.updateOrder(orderId, fields);
  }
}
