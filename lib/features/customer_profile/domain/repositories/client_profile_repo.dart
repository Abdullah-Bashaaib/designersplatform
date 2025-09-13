import 'package:dartz/dartz.dart';
import 'package:designers_platform/core/error/failures.dart';
import 'package:designers_platform/features/customer_profile/domain/entities/client.dart';

abstract class ClientProfileRepo {
  Future<Either<Failure, Client>> getProfile();
  Future<Either<Failure, Unit>> updateProfile(Client client);
  Future<Either<Failure, Unit>> deleteProfile();
}
