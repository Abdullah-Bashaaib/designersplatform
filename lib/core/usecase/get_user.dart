import 'package:designers_platform/features/auth/domain/entities/user.dart';
import 'package:designers_platform/features/auth/domain/repositories/auth_repository.dart';

class GetUserUsecase {
  final AuthRepository authRepository;

  GetUserUsecase(this.authRepository);

  Future<User> call() async {
    return await authRepository.getUser();
  }
}
