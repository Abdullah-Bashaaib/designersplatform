import 'package:designers_platform/features/auth/domain/entities/user.dart';
import 'package:designers_platform/features/auth/domain/repositories/auth_repository.dart';

class GetUserUseCase {
  final AuthRepository authRepository;

  GetUserUseCase(this.authRepository);

  Future<User> call() async {
    return await authRepository.getUser();
  }
}
