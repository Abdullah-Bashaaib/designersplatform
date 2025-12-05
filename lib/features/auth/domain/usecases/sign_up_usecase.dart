import 'package:dartz/dartz.dart';
import 'package:designers_platform/core/error/failures.dart';
import 'package:designers_platform/features/auth/domain/entities/user.dart';
import 'package:designers_platform/features/auth/domain/repositories/auth_repository.dart';

class SignUpUsecase {
  final AuthRepository authRepository;

  SignUpUsecase(this.authRepository);

  Future<Either<Failure, UserEntity>> call(UserEntity user, String password) async {
    return await authRepository.signUp(user, password);
  }
}
