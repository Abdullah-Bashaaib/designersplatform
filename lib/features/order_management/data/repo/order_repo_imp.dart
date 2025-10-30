import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:designers_platform/core/error/exception.dart';
import 'package:designers_platform/core/error/failures.dart';
import 'package:designers_platform/core/utils/messages.dart';
import 'package:designers_platform/features/order_management/data/datasource/order_remote.dart';
import 'package:designers_platform/features/order_management/data/models/order_model.dart';
import 'package:designers_platform/features/order_management/domain/entity/orders.dart';
import 'package:designers_platform/features/order_management/domain/repo/order_repo.dart';

import '../../../../core/domain/i_internet_info.dart';

class OrderRepoImp implements OrderRepo {
  final OrderRemote orderRemote;
  final INetworkInfo networkInfo;

  OrderRepoImp(this.orderRemote, this.networkInfo);
  @override
  Future<Either<Failure, Unit>> addOrder(OrderEntity order) async {
    final orderModel = OrderModel(
      id: order.id,
      clientId: order.clientId,
      clientName: order.clientName,
      designerId: order.designerId,
      designerName: order.designerName,
      designType: order.designType,
      description: order.description,
      status: order.status,
      createAt: order.createAt,
    );
    if (await networkInfo.isConnected) {
      try {
        await orderRemote.addOrder(orderModel);
        return right(unit);
      } on ServerException catch (e) {
        return left(ServerFailure(e.message.toString()));
      }
    } else {
      return left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, List<OrderEntity>>> getOrders() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await orderRemote.getOrders('designerId');
        if (result.isEmpty) {
          log("-------------> message:there is empty data!!");
          return left(NoDataFailure(emptyOrdersMessage));
        }
        return right(result);
      } on ServerException catch (e) {
        return left(ServerFailure(e.message.toString()));
      }
    } else {
      return left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteOrder(String orderId) async {
    if (await networkInfo.isConnected) {
      try {
        await orderRemote.deleteOrder(orderId);
        return right(unit);
      } on ServerException catch (e) {
        return left(ServerFailure(e.message.toString()));
      }
    } else {
      return left(OfflineFailure());
    }
  }
}
