import 'package:dartz/dartz.dart';
import 'package:designers_platform/core/error/failures.dart';
import 'package:designers_platform/features/order_management/domain/entity/orders.dart';

abstract class OrderRepo {
  Future<Either<Failure, Unit>> addOrder(OrderEntity order);
  Future<Either<Failure, List<OrderEntity>>> getOrders();
  Future<Either<Failure, Unit>> deleteOrder(String orderId);
}
