import 'package:dartz/dartz.dart';
import 'package:designers_platform/features/order_management/domain/entity/orders.dart';
import 'package:designers_platform/features/order_management/domain/repo/order_repo.dart';

import '../../../../core/error/failures.dart';

class GetOrdersUsecase {
  final OrderRepo repo;

  GetOrdersUsecase(this.repo);

  Future<Either<Failure, List<OrderEntity>>> call(String column) async {
    return await repo.getOrders(column);
  }
}
