import 'package:designers_platform/features/customer_profile/domain/entities/client.dart';

abstract class ClientLocalDataSource {
  Future<void> updateProfile(Client client);
}

class ClientLocalDataSourceImp implements ClientLocalDataSource {
  @override
  Future<void> updateProfile(Client client) {
    throw UnimplementedError();
  }
}
