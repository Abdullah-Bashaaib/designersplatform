import 'package:designers_platform/core/error/failures.dart';
import 'package:designers_platform/features/auth/domain/entities/user.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login(String email, String password);
  Future<Either<Failure, User>> signUp(User user);
  Either<Failure, User> getUser();
  Future<void> clearUser();
  bool isLoggedIn();
  Future<bool> deleteAccount();
  Future<Either<Failure, String>> addAvatar(String userId, String filePath);
  Future<Either<Failure, Unit>> forgetPassword(String newPassword);
}
