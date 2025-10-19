import 'package:dartz/dartz.dart';
import 'package:designers_platform/core/error/failures.dart';
import 'package:designers_platform/features/order_management/domain/entity/orders.dart';
import 'package:designers_platform/features/order_management/domain/repo/order_repo.dart';

class AddOrderUsecase {
  final OrderRepo repo;

  AddOrderUsecase(this.repo);

  Future<Either<Failure, Unit>> call(OrderEntity order) async {
    return await repo.addOrder(order);
  }
}
