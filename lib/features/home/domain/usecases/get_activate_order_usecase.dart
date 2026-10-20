import 'package:dartz/dartz.dart';
import 'package:designers_platform/core/error/failures.dart';
import 'package:designers_platform/features/home/domain/repo/home_repo.dart';
import 'package:designers_platform/features/order_management/domain/entity/orders.dart';

class GetActivateOrderUsecase {
  final HomeRepo repo;

  GetActivateOrderUsecase(this.repo);

  Future<Either<Failure, List<OrderEntity>>> call() async {
    return await repo.getActivateOrders();
  }
}
