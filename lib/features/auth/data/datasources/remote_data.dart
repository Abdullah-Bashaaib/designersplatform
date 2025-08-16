import 'package:designers_platform/features/auth/domain/entities/login.dart';

abstract class RemoteData {
  Future<bool> checkAcountInRemote(Login login);
 }


 class RemoteDataSorce implements RemoteData{
  @override
  Future<bool> checkAcountInRemote(Login login) {
    // TODO: implement checkAcountInRemote
    throw UnimplementedError();
  }

 }