import 'package:designers_platform/core/error/failures.dart';
import 'package:designers_platform/features/auth/domain/entities/user.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login(String email, String password);
  Future<Either<Failure, UserEntity>> signUp(UserEntity user, String password);
  Either<Failure, UserEntity> getUser();
  void logout();
  bool isLoggedIn();
  Future<Either<Failure, Unit>> deleteAccount();
  Future<Either<Failure, Unit>> forgetPassword(String email);
}
