import 'package:designers_platform/core/error/failures.dart';
import 'package:designers_platform/features/auth/domain/entities/user.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login(String email, String password);
}
