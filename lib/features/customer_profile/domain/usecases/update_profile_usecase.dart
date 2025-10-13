import 'package:dartz/dartz.dart';
import 'package:designers_platform/core/error/failures.dart';
import 'package:designers_platform/features/customer_profile/domain/repositories/client_profile_repo.dart';

class UpdateProfileUsecase {
  final ClientProfileRepo clientProfileRepo;

  UpdateProfileUsecase(this.clientProfileRepo);

  Future<Either<Failure, Unit>> call(String name) async {
    return await clientProfileRepo.updateUserName(name);
  }
}
