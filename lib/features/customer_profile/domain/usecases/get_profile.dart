import 'package:dartz/dartz.dart';
import 'package:designers_platform/core/error/failures.dart';
import 'package:designers_platform/features/customer_profile/domain/entities/client.dart';
import 'package:designers_platform/features/customer_profile/domain/repositories/client_profile_repo.dart';

class GetProfileUsecase {
  final ClientProfileRepo repo;

  GetProfileUsecase(this.repo);

  Either<Failure, Client> call() {
    return repo.getProfile();
  }
}
