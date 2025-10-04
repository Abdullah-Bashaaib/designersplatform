import 'package:dartz/dartz.dart';
import 'package:designers_platform/features/customer_profile/domain/repositories/client_profile_repo.dart';

import '../../features/auth/domain/entities/user.dart';
import '../error/failures.dart';

class SaveUserUsecase {
  final ClientProfileRepo clientProfileRepo;

  SaveUserUsecase(this.clientProfileRepo);

  Either<Failure, Unit> call(User user) {
    return clientProfileRepo.saveUser(user);
  }
}
