import 'package:dartz/dartz.dart';
import 'package:designers_platform/features/customer_profile/domain/repositories/client_profile_repo.dart';
import 'package:designers_platform/features/order_management/domain/entity/orders.dart';

import '../../../../core/error/failures.dart';

class GetOrdersUsecase {
  final ClientProfileRepo repo;

  GetOrdersUsecase(this.repo);

  Future<Either<Failure, List<OrderEntity>>> call() async {
    return await repo.getOrders();
  }
}
