import '../../domain/entities/user.dart';

abstract class RemoteData {
  Future<User> checkAccountInRemote(String email, String password);
}

class RemoteDataSource implements RemoteData {
  @override
  Future<User> checkAccountInRemote(String email, String password) {
    // TODO: implement checkAccountInRemote
    throw UnimplementedError();
  }
}
