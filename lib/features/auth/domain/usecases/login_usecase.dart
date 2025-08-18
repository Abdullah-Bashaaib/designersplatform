import 'package:dartz/dartz.dart';
import 'package:designers_platform/features/auth/domain/entities/user.dart';
import 'package:designers_platform/features/auth/domain/repositories/auth_repository.dart';

import '../../../../core/error/failures.dart';

class LoginUsecase {
  final AuthRepository authRepository;

  LoginUsecase(this.authRepository);

  Future<Either<Failure, User>> call(String email, String password) async {
    return await authRepository.login(email, password); 
  }
}