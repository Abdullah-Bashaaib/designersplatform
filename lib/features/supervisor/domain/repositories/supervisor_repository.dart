import 'package:dartz/dartz.dart';
import 'package:designers_platform/core/error/failures.dart';
import 'package:designers_platform/features/order_management/domain/entity/orders.dart';

abstract class SupervisorRepository {
  Future<Either<Failure, List<OrderEntity>>> getPendingOrders();
  Future<Either<Failure, Unit>> approveOrder(String orderId);
  Future<Either<Failure, Unit>> updateSupervisorProfile(
      String userId, Map<String, dynamic> data);
}
