import 'package:dartz/dartz.dart';
import 'package:designers_platform/core/error/failures.dart';
import 'package:designers_platform/features/designer_profile/domain/entities/designer.dart';
import 'package:designers_platform/features/designer_profile/domain/repositories/designer_repository.dart';

class UpdateProfileUseCase {
  final DesignerRepository designerRepository;

  UpdateProfileUseCase({required this.designerRepository});

  Future<Either<Failure, Unit>> call(Designer designer) async {
    return await designerRepository.updateProfile(designer);
  }
}
