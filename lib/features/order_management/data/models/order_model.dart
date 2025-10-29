import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:designers_platform/features/order_management/domain/entity/orders.dart';

class OrderModel extends OrderEntity {
  OrderModel({
    required super.id,
    required super.clientId,
    required super.clientName,
    required super.designerId,
    required super.designerName,
    required super.designName,
    required super.designType,
    super.description,
    super.price,
    required super.status,
    super.rate,
    super.imageUrl,
    super.feedback,
    required super.createAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] ?? '',
      clientId: json['clientId'] ?? '',
      clientName: json['clientName'] ?? '',
      designerId: json['designerId'] ?? '',
      designerName: json['designerName'] ?? '',
      designName: json['designName'] ?? '',
      designType: json['designType'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] ?? 0.0,
      status: json['status'] ?? '',
      rate: json['rate'] ?? 0,
      imageUrl: json['imageUrl'] ?? '',
      feedback: json['feedback'] ?? '',
      createAt: json['createAt'] is Timestamp
          ? (json['createAt'] as Timestamp).toDate()
          : json['createAt'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'clientId': clientId,
      'clientName': clientName,
      'designerId': designerId,
      'designerName': designerName,
      'designName': designName,
      'designType': designType,
      'description': description ?? '',
      'price': price ?? 0.0,
      'status': status,
      'rate': rate ?? 0,
      'imageUrl': imageUrl ?? '',
      'feedback': feedback ?? '',
      'createAt': createAt,
    };
  }
}
