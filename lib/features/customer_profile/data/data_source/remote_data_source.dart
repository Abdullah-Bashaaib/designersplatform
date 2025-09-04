import 'package:designers_platform/features/customer_profile/domain/entities/client.dart';

abstract class ClientRemoteDataSource {
  Future<void> updateProfile(Client client);
}

class ClientRemoteDataSourceImp implements ClientRemoteDataSource {
  @override
  Future<void> updateProfile(Client client) {
    throw UnimplementedError();
  }
}
