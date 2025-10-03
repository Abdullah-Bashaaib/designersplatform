import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:designers_platform/features/customer_profile/domain/repositories/client_profile_repo.dart';

import '../../../../core/error/failures.dart';

class AddAvatarUsecase {
  final ClientProfileRepo clientProfileRepo;

  AddAvatarUsecase(this.clientProfileRepo);

  Future<Either<Failure, String>> call(File file) async {
    return await clientProfileRepo.addAvatar(file);
  }
}
