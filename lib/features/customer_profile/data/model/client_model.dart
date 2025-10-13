import 'package:designers_platform/features/customer_profile/domain/entities/client.dart';

class ClientModel extends Client {
  ClientModel({required super.userId, super.favorites, super.orders});

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
      userId: json['userId'],
      favorites: json['favorites'],
      orders: json['orders'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userid': userId,
      'favorites': favorites,
      'orders': orders,
    };
  }
}
