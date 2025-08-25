import '../../domain/entities/user.dart';

abstract class RemoteData {
  Future<User> checkAccountInRemote(String email, String password);
  Future<User> signUp(User user);
}

class RemoteDataSource implements RemoteData {
  @override
  Future<User> checkAccountInRemote(String email, String password) {
    throw UnimplementedError();
  }
  
  @override
  Future<User> signUp(User user) {
    throw UnimplementedError();
  }
}
