import 'package:dartz/dartz.dart';
import 'package:designers_platform/core/error/failures.dart';
import 'package:designers_platform/features/customer_profile/domain/entities/client.dart';

abstract class ClientProfileRepo {
  Future<Either<Failure, Unit>> updateProfile(Client client);
  Future<Either<Failure, String>> getAvatar(String userId, String filePath);
  Future<Either<Failure, Unit>> updatePassword(String userId, String password);
  Future<Either<Failure, Unit>> updateAvatar(String userId, String filePath);
}
