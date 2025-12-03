import 'package:dartz/dartz.dart';
import 'package:designers_platform/features/search/domain/repo/search_repo.dart';

import '../../../../core/error/failures.dart';

class SearchDesignsUsecase {
  final SearchRepo repo;

  SearchDesignsUsecase(this.repo);

  Future<Either<Failure, List<Map<String, dynamic>>>> call(String query) async {
    return await repo.searchDesigns(query);
  }
}
