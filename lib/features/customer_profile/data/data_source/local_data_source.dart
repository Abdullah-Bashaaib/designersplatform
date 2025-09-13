import 'package:designers_platform/core/current_user.dart';
import 'package:designers_platform/core/error/exception.dart';
import 'package:designers_platform/features/customer_profile/data/model/client_model.dart';
import 'package:designers_platform/features/customer_profile/domain/entities/client.dart';
import 'package:sqflite/sqflite.dart';

abstract class ClientLocalDataSource {
  Future<void> updateProfile(Client client);
  Future<Client> getProfile();
  Future<void> deleteProfile();
}

class ClientLocalDataSourceImp implements ClientLocalDataSource {
  final Database _db;

  ClientLocalDataSourceImp(this._db);

  @override
  Future<void> updateProfile(Client client) async {
    try {
      ClientModel clientModel = ClientModel(user: client.user);
      await _db.update('Users', clientModel.toMap());
    } catch (e) {
      throw LocalException();
    }
  }

  @override
  Future<void> deleteProfile() async {
    try {
      await _db.delete('Users',
          where: 'id = ?', whereArgs: [CurrentUser.currentUser!.id]);
    } catch (e) {
      throw LocalException();
    }
  }

  @override
  Future<Client> getProfile() async {
    final result = await _db.query('Users',
        where: 'id = ?', whereArgs: [CurrentUser.currentUser!.id]);
    if (result.isNotEmpty) {
      final client = ClientModel.fromJson(result.first);
      return client;
    } else {
      throw LocalException();
    }
  }
}
