import 'package:dartz/dartz.dart';
import 'package:designers_platform/core/error/failures.dart';
import 'package:designers_platform/features/auth/domain/repositories/auth_repository.dart';

class ForgetPasswordUsecase {
  final AuthRepository authRepository;

  ForgetPasswordUsecase(this.authRepository);

  Future<Either<Failure, Unit>> call(String newPassword) async {
    return await authRepository.forgetPassword(newPassword);
  }
}
