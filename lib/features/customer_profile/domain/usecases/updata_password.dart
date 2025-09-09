import 'package:dartz/dartz.dart';
import 'package:designers_platform/core/error/failures.dart';
import 'package:designers_platform/features/customer_profile/domain/repositories/client_profile_repo.dart';

class UpdataPasswordUsecase {
  final ClientProfileRepo repo;

  UpdataPasswordUsecase(this.repo);

  Future<Either<Failure, Unit>> call(String userId, String password) async {
    return await repo.updatePassword(userId, password);
  }
}
