import 'package:dartz/dartz.dart';
import 'package:designers_platform/core/error/failures.dart';
import 'package:designers_platform/features/customer_profile/domain/repositories/client_profile_repo.dart';

class UpdateAvatarUsecase {
  final ClientProfileRepo repo;

  UpdateAvatarUsecase(this.repo);

  Future<Either<Failure, Unit>> call(String userId, String filePath) async {
    return await repo.updateAvatar(userId, filePath);
  }
}
