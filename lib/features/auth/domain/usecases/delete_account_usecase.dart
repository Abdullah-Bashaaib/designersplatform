import 'package:dartz/dartz.dart';
import 'package:designers_platform/core/error/failures.dart';
import 'package:designers_platform/features/auth/domain/repositories/auth_repository.dart';

class DeleteAccountUsecase {
  final AuthRepository authRepository;

  DeleteAccountUsecase(this.authRepository);

  Future<Either<Failure, Unit>> call() async {
    return await authRepository.deleteAccount();
  }
}
