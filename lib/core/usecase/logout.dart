import 'package:designers_platform/features/auth/domain/repositories/auth_repository.dart';

class LogoutUsecase {
  final AuthRepository authRepository;

  LogoutUsecase(this.authRepository);

  void call() {
    authRepository.logout();
  }
}
