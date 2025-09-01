import 'package:designers_platform/core/error/exception.dart';

import '../../domain/entities/user.dart';

abstract class RemoteData {
  Future<User> checkAccountInRemote(String email, String password);
  Future<User> signUp(User user);
  Future<bool> deleteAccount();
}

class RemoteDataSource implements RemoteData {
  List<User> users = [
    User(id: '2', name: 'salem', email: 'sas@gmail.com', password: '12345678', role: 'عميل'),
  ];
  @override
  Future<User> checkAccountInRemote(String email, String password) async {
    try {
      User user =
          users.firstWhere((u) => u.email == email && u.password == password);
      return user;
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<User> signUp(User user) async {
    users.add(user);
    return user;
  }

  @override
  Future<bool> deleteAccount() {
    throw UnimplementedError();
  }
}
