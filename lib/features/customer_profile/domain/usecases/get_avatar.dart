import 'package:dartz/dartz.dart';
import 'package:designers_platform/core/error/failures.dart';
import 'package:designers_platform/features/customer_profile/domain/repositories/client_profile_repo.dart';

class GetAvatarUsecase {
  final ClientProfileRepo repo;

  GetAvatarUsecase(this.repo);

  Future<Either<Failure, String>> call(String userId, String filePath) async {
    return await repo.getAvatar(userId, filePath);
  }
}
