import 'package:designers_platform/features/auth/data/models/user_model.dart';
import 'package:designers_platform/features/customer_profile/domain/entities/client.dart';

class ClientModel extends Client {
  ClientModel({required super.user});

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
      user: UserModel.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user': (user as UserModel).toMap(),
    };
  }
}
