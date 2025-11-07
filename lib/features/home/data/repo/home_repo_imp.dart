import 'package:dartz/dartz.dart';
import 'package:designers_platform/core/domain/i_internet_info.dart';
import 'package:designers_platform/core/error/exception.dart';
import 'package:designers_platform/core/error/failures.dart';
import 'package:designers_platform/features/designer_profile/domain/entities/designer.dart';
import 'package:designers_platform/features/home/data/datasource/remote.dart';
import 'package:designers_platform/features/home/domain/repo/home_repo.dart';

class HomeRepoImp implements HomeRepo {
  final INetworkInfo networkInfo;
  final Remote remote;

  HomeRepoImp(this.networkInfo, this.remote);

  @override
  Future<Either<Failure, List<Designer>>> getDesigners() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remote.getDesigners();
        return right(result);
      } on ServerException catch (e) {
        return left(ServerFailure(e.message.toString()));
      }
    } else {
      return left(OfflineFailure());
    }
  }
}
