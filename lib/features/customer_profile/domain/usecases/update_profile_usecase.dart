import 'package:dartz/dartz.dart';
import 'package:designers_platform/core/error/failures.dart';
import 'package:designers_platform/features/customer_profile/domain/entities/client.dart';
import 'package:designers_platform/features/customer_profile/domain/repositories/client_profile_repo.dart';

class UpdateProfileUsecase {
  final ClientProfileRepo clientProfileRepo;

  UpdateProfileUsecase(this.clientProfileRepo);

  Future<Either<Failure, Unit>> call(Client client) async {
    return await clientProfileRepo.updateProfile(client);
  }
}
