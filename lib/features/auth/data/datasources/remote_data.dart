import 'package:dartz/dartz.dart';

import '../../domain/entities/user.dart';

abstract class RemoteData {
  Future<Either<String, User>> checkAccountInRemote(String email, String password);
  Future<User> signUp(User user);
}

class RemoteDataSource implements RemoteData {
  List<User> users = [
    User(id: '2', name: 'salem', email: 'sas@gmail.com', password: '12345678'),
  ];
  @override
  Future<Either<String, User>> checkAccountInRemote(
      String email, String password) async {
    try {
      User user =
          users.firstWhere((u) => u.email == email && u.password == password);
      return right(user); // المستخدم موجود
    } catch (e) {
      return left('المستخدم غير موجود');
    }
  }

  @override
  Future<User> signUp(User user) async {
    users.add(user);
    return user;
  }
}
