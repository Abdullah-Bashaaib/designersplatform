import 'package:dartz/dartz.dart';
import 'package:designers_platform/core/error/failures.dart';
import 'package:designers_platform/features/designer_profile/domain/repositories/designer_repository.dart';

class DeleteProfileUseCase {
  final DesignerRepository designerRepository;

  DeleteProfileUseCase({required this.designerRepository});

  Future<Either<Failure, Unit>> call(String id) async {
    return await designerRepository.deleteProfile(id);
  }
}
