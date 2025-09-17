import 'package:dartz/dartz.dart';
import 'package:designers_platform/features/customer_profile/domain/repositories/client_profile_repo.dart';

import '../../../../core/error/failures.dart';
import '../../../auth/domain/entities/user.dart';

class GetFavoritesUsecase {
  final ClientProfileRepo clientProfileRepo;

  GetFavoritesUsecase(this.clientProfileRepo);

  Future<Either<Failure, List<User>>> call() async {
    return await clientProfileRepo.getFavoritesList();
  }
}
