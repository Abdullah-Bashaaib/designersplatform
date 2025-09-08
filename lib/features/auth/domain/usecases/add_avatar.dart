import 'package:dartz/dartz.dart';
import 'package:designers_platform/core/error/failures.dart';
import 'package:designers_platform/features/auth/domain/repositories/auth_repository.dart';

class AddAvatarUsecase {
  final AuthRepository repo;

  AddAvatarUsecase(this.repo);

  Future<Either<Failure, String>> call(String userId, String filePath) async {
    return await repo.addAvatar(userId, filePath);
  }
}
