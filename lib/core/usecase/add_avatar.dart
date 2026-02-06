
import 'package:dartz/dartz.dart';
import 'package:designers_platform/features/customer_profile/domain/repositories/client_profile_repo.dart';
import 'package:image_picker/image_picker.dart';

import '../error/failures.dart';

class AddAvatarUsecase {
  final ClientProfileRepo clientProfileRepo;

  AddAvatarUsecase(this.clientProfileRepo);

  Future<Either<Failure, String>> call(XFile file) async {
    return await clientProfileRepo.addAvatar(file);
  }
}
