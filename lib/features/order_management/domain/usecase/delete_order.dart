import 'package:dartz/dartz.dart';
import 'package:designers_platform/core/error/failures.dart';
import 'package:designers_platform/features/order_management/domain/repo/order_repo.dart';

class DeleteOrderUsecase {
  final OrderRepo repo;

  DeleteOrderUsecase(this.repo);

  Future<Either<Failure, Unit>> call(String orderId) async {
    return await repo.deleteOrder(orderId);
  }
}
