import 'package:designers_platform/features/auth/domain/repositories/auth_repository.dart';

class ClearUserUsecase {
  final AuthRepository authRepository;

  ClearUserUsecase(this.authRepository);

  Future<void> call() async {
    await authRepository.clearUser();
  }
}
