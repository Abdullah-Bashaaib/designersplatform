import 'package:dartz/dartz.dart';
import 'package:designers_platform/core/error/failures.dart';
import 'package:designers_platform/features/order_management/domain/repo/order_repo.dart';

class GetSupervisorPhoneUsecase {
  final OrderRepo repo;

  GetSupervisorPhoneUsecase(this.repo);

  Future<Either<Failure, int>> call() async {
    return await repo.getSupervisorPhone();
  }
}
