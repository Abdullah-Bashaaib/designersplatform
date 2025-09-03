import 'package:designers_platform/features/customer_profile/domain/entities/client.dart';

abstract class LocalDataSource {
  Future<void> updateProfile(Client client);
}

class LocalDataSourceImp implements LocalDataSource {
  @override
  Future<void> updateProfile(Client client) {
    throw UnimplementedError();
  }
}
