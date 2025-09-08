import 'package:dartz/dartz.dart';
import 'package:designers_platform/core/error/failures.dart';
import 'package:designers_platform/features/designer_profile/domain/entities/designer.dart';
import 'package:designers_platform/features/designer_profile/domain/repositories/designer_repository.dart';

class GetProfileUseCase {
  final DesignerRepository designerRepository;

  GetProfileUseCase({required this.designerRepository});

  Future<Either<Failure, Designer>> call(int id) async {
    return await designerRepository.getDesigner(id);
  }
}
