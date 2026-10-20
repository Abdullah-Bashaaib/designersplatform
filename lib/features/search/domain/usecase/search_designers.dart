import 'package:dartz/dartz.dart';
import 'package:designers_platform/features/designer_profile/domain/entities/designer.dart';

import '../../../../core/error/failures.dart';
import '../repo/search_repo.dart';

class SearchDesignersUsecase {
  final SearchRepo repo;

  SearchDesignersUsecase(this.repo);

  Future<Either<Failure, List<Designer>>> call(String query) async {
    return await repo.searchDesigners(query);
  }
}
