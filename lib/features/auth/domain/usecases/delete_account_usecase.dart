import 'package:designers_platform/features/auth/domain/repositories/auth_repository.dart';

class DeleteAccountUsecase {
  final AuthRepository authRepository;

  DeleteAccountUsecase(this.authRepository);

  Future<bool> call() async {
    return await authRepository.deleteAccount();
  }
}
