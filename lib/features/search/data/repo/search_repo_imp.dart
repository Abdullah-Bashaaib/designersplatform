import 'package:dartz/dartz.dart';
import 'package:designers_platform/core/domain/i_internet_info.dart';
import 'package:designers_platform/core/error/exception.dart';
import 'package:designers_platform/core/error/failures.dart';
import 'package:designers_platform/features/designer_profile/domain/entities/designer.dart';
import 'package:designers_platform/features/search/data/datasurce/search_remote.dart';
import 'package:designers_platform/features/search/domain/repo/search_repo.dart';

class SearchRepoImp implements SearchRepo {
  final INetworkInfo networkInfo;
  final SearchRemote remote;

  SearchRepoImp(this.networkInfo, this.remote);

  @override
  Future<Either<Failure, List<Designer>>> searchDesigners(String query) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remote.searchDesigners(query);
        return right(result);
      } on ServerException catch (e) {
        return left(ServerFailure(e.message.toString()));
      }
    } else {
      return left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> searchDesigns(
      String query) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remote.searchDesigns(query);
        return right(result);
      } on ServerException catch (e) {
        return left(ServerFailure(e.message.toString()));
      }
    } else {
      return left(OfflineFailure());
    }
  }
}
