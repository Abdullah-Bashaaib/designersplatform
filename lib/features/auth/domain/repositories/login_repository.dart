import 'package:designers_platform/features/auth/domain/entities/login.dart';

abstract class LoginRepository {
  Future<bool> checkAcount(Login login);
}
