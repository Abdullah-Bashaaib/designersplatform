import 'package:dartz/dartz.dart';
import 'package:designers_platform/core/error/exception.dart';
import 'package:designers_platform/core/error/failures.dart';
import 'package:designers_platform/features/order_management/domain/entity/orders.dart';
import 'package:designers_platform/features/supervisor/data/datasources/supervisor_remote_datasource.dart';
import 'package:designers_platform/features/supervisor/domain/repositories/supervisor_repository.dart';

class SupervisorRepositoryImpl implements SupervisorRepository {
  final SupervisorRemoteDataSource remoteDataSource;

  SupervisorRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<OrderEntity>>> getPendingOrders() async {
    try {
      final orders = await remoteDataSource.getPendingOrders();
      return Right(orders);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> approveOrder(String orderId) async {
    try {
      await remoteDataSource.approveOrder(orderId);
      return Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> updateSupervisorProfile(
      String userId, Map<String, dynamic> data) async {
    try {
      await remoteDataSource.updateSupervisorProfile(userId, data);
      return Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
