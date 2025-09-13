import 'package:dartz/dartz.dart';
import 'package:designers_platform/core/error/failures.dart';
import 'package:designers_platform/features/customer_profile/domain/repositories/client_profile_repo.dart';

class DeleteProfileUsecase {
  final ClientProfileRepo repo;

  DeleteProfileUsecase(this.repo);

  Future<Either<Failure, Unit>> call() async {
    return await repo.deleteProfile();
  }
}
