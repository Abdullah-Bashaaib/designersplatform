import 'package:designers_platform/features/customer_profile/domain/entities/client.dart';

abstract class RemoteDataSource {
  Future<void> updateProfile(Client client);
}

class RemoteDataSourceImp implements RemoteDataSource {
  @override
  Future<void> updateProfile(Client client) {
    throw UnimplementedError();
  }
}
