import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:designers_platform/core/error/failures.dart';
import 'package:designers_platform/features/customer_profile/domain/entities/client.dart';
import 'package:designers_platform/features/customer_profile/domain/entities/order_entity.dart';

import '../../../auth/domain/entities/user.dart';

abstract class ClientProfileRepo {
  Either<Failure, Client> getProfile();
  Future<Either<Failure, Unit>> updateProfile(Client client);
  Future<Either<Failure, List<User>>> getFavoritesList();
  Future<Either<Failure, List<OrderEntity>>> getOrders();
  Future<Either<Failure, String>> addAvatar(File file);
}
