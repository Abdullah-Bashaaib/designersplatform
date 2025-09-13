import 'package:designers_platform/features/customer_profile/domain/entities/client.dart';

abstract class ClientRemoteDataSource {
  Future<void> updateProfile(Client client);
  Future<void> getAvatar(String userId, String filePath);
  Future<void> updateAvatar(String userId, String filePath);
  Future<void> updatePassword(String userId, String password);
}

class ClientRemoteDataSourceImp implements ClientRemoteDataSource {
  @override
  Future<void> updateProfile(Client client) {
    throw UnimplementedError();
  }
  
  @override
  Future<void> getAvatar(String userId, String filePath) {
    // TODO: implement getAvatar
    throw UnimplementedError();
  }
  
  @override
  Future<void> updateAvatar(String userId, String filePath) {
    // TODO: implement updateAvatar
    throw UnimplementedError();
  }
  
  @override
  Future<void> updatePassword(String userId, String password) {
    // TODO: implement updatePassword
    throw UnimplementedError();
  }
}
