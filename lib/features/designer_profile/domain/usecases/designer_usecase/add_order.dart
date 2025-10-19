import 'package:dartz/dartz.dart';
import 'package:designers_platform/core/error/failures.dart';
import 'package:designers_platform/features/designer_profile/domain/repositories/designer_repository.dart';
import 'package:designers_platform/features/order_management/domain/entity/orders.dart';

class AddOrderUsecase {
  final DesignerRepository designerRepository;

  AddOrderUsecase(this.designerRepository);

  Future<Either<Failure, Unit>> call(OrderEntity order) async {
    return await designerRepository.addOrder(order);
  }
}