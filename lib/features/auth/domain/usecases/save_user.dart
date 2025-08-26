import 'package:designers_platform/features/auth/domain/entities/user.dart';
import 'package:designers_platform/features/auth/domain/repositories/auth_repository.dart';

class SaveUserUsecase {
  final AuthRepository authRepository;

  SaveUserUsecase(this.authRepository);

  Future<void> call(User user) async {
    await authRepository.saveUser(user);
  }
}
