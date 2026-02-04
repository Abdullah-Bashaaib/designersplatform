import 'package:dartz/dartz.dart';
import 'package:designers_platform/core/domain/i_internet_info.dart';
import 'package:designers_platform/core/error/exception.dart';
import 'package:designers_platform/core/error/failures.dart';
import 'package:designers_platform/features/designer_profile/domain/entities/designer.dart';
import 'package:designers_platform/features/home/data/datasource/remote.dart';
import 'package:designers_platform/features/home/domain/repo/home_repo.dart';
import 'package:designers_platform/features/order_management/domain/entity/orders.dart';

class HomeRepoImp implements HomeRepo {
  final INetworkInfo networkInfo;
  final Remote remote;

  HomeRepoImp(this.networkInfo, this.remote);

  @override
  Future<Either<Failure, List<Designer>>> getDesigners(
      {int limit = 10, Designer? startAfter}) async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await remote.getDesigners(limit: limit, startAfter: startAfter);
        return right(result);
      } on ServerException catch (e) {
        return left(ServerFailure(e.message.toString()));
      }
    } else {
      return left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, List<OrderEntity>>> getActivateOrders() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remote.getActivateOrders();
        return right(result);
      } on ServerException catch (e) {
        return left(ServerFailure(e.message.toString()));
      }
    } else {
      return left(OfflineFailure());
    }
  }
}
