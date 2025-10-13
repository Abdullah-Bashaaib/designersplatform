import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:designers_platform/core/error/failures.dart';
import 'package:designers_platform/features/customer_profile/domain/entities/client.dart';
import 'package:designers_platform/features/order_management/domain/entity/orders.dart';
import 'package:image_picker/image_picker.dart';

import '../../../auth/domain/entities/user.dart';

abstract class ClientProfileRepo {
  Either<Failure, Client> getProfile();
  Future<Either<Failure, Unit>> updateUserName(String name);
  Future<Either<Failure, List<User>>> getFavoritesList();
  Future<Either<Failure, List<OrderEntity>>> getOrders();
  Future<Either<Failure, String>> addAvatar(XFile file);
  Either<Failure, Unit> saveUser(User user);
  Future<Either<Failure, Unit>> deleteAvatar();
}
