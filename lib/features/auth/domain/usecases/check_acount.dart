import 'package:designers_platform/features/auth/domain/entities/login.dart';
import 'package:designers_platform/features/auth/domain/repositories/login_repository.dart';

class CheckAcount {
  final LoginRepository loginRepository;

  CheckAcount(this.loginRepository);

  Future<bool> call(Login login) async {
    return await loginRepository.checkAcount(login);
  }
}