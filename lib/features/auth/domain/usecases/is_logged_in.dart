import 'package:designers_platform/features/auth/domain/repositories/auth_repository.dart';

class IsLoggedInUsecase {
  final AuthRepository authRepository;

  IsLoggedInUsecase(this.authRepository);
  bool call() {
    return authRepository.isLoggedIn();
  }
}
