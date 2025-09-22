import 'package:designers_platform/features/customer_profile/domain/entities/order_entity.dart';

class OrderModel extends OrderEntity {
  OrderModel(
      {required super.clientId,
      required super.designerId,
      required super.imageUrl});

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
        clientId: json['clientId'],
        designerId: json['designerId'],
        imageUrl: json['imageUrl']);
  }

  Map<String, dynamic> toMap() {
    return {};
  }
}
