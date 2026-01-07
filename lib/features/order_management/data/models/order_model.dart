import 'package:designers_platform/features/order_management/domain/entity/orders.dart';

class OrderModel extends OrderEntity {
  OrderModel({
    required super.id,
    required super.clientId,
    required super.clientName,
    required super.designerId,
    required super.designerName,
    required super.designType,
    super.description,
    super.price,
    required super.status,
    super.rate,
    super.imageUrl,
    super.feedback,
    required super.createAt,
    super.adminApproval,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
        id: json['id'] ?? '',
        clientId: json['clientId'] ?? '',
        clientName: json['clientName'] ?? '',
        designerId: json['designerId,'] ?? '',
        designerName: json['designerName'] ?? '',
        designType: json['designType'] ?? '',
        description: json['description'] ?? '',
        price: (json['price'] as num).toDouble(),
        status: json['status'] ?? '',
        rate: json['rate'] ?? 0,
        imageUrl: json['imageUrl'] ?? '',
        feedback: json['feedback'] ?? '',
        createAt: DateTime.parse(json['createAt'] as String),
        adminApproval: json['adminApproval']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'clientId': clientId,
      'clientName': clientName,
      'designerId': designerId,
      'designerName': designerName,
      'designType': designType,
      'description': description ?? '',
      'price': price ?? 0.0,
      'status': status,
      'rate': rate ?? 0,
      'imageUrl': imageUrl ?? '',
      'feedback': feedback ?? '',
      'createAt': createAt.toIso8601String(),
      'adminApproval': adminApproval ?? '',
    };
  }
}
