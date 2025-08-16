import 'package:designers_platform/core/network/network_info.dart';
import 'package:designers_platform/features/auth/data/datasources/remote_data.dart';
import 'package:designers_platform/features/auth/domain/repositories/login_repository.dart';

class LoginRepositoryImp implements LoginRepository {
  final NetworkInfo networkInfo;
  final RemoteDataSorce remoteDataSorce;

  LoginRepositoryImp(this.networkInfo, this.remoteDataSorce);
  @override
  Future<bool> checkAcount() async {
    if(await networkInfo.isConnected){
      await remoteDataSorce.checkAcountInRemote();
      return true;
    }
    return false;
  }

}