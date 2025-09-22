import 'package:dartz/dartz.dart';
import 'package:designers_platform/features/customer_profile/domain/repositories/client_profile_repo.dart';

import '../../../../core/error/failures.dart';
import '../entities/order_entity.dart';

class GetOrdersUsecase {
  final ClientProfileRepo repo;

  GetOrdersUsecase(this.repo);

  Future<Either<Failure, List<OrderEntity>>> call() async {
    return await repo.getOrders();
  }
}
