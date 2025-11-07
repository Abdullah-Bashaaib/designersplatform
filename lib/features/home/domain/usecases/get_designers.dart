import 'package:dartz/dartz.dart';
import 'package:designers_platform/core/error/failures.dart';
import 'package:designers_platform/features/designer_profile/domain/entities/designer.dart';
import 'package:designers_platform/features/home/domain/repo/home_repo.dart';

class GetDesignersUsecase {
  final HomeRepo homeRepo;

  GetDesignersUsecase(this.homeRepo);

  Future<Either<Failure, List<Designer>>> call() async {
    return await homeRepo.getDesigners();
  }

}