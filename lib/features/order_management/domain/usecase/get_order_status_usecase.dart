import 'package:dartz/dartz.dart';
import 'package:designers_platform/core/error/failures.dart';
import 'package:designers_platform/features/order_management/domain/repo/order_repo.dart';

class GetOrderStatusUseCase {
  final OrderRepo repo;

  GetOrderStatusUseCase(this.repo);

  Future<Either<Failure, String>> call(String orderId) async {
    return await repo.getOrderStatus(orderId);
  }
}
