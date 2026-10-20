class OrderEntity {
  final String id;
  final String clientId;
  final String clientName;
  final String designerId;
  final String designerName;
  String designType;
  String? description;
  final double? price;
  String status;
  final DateTime createAt;
  final String? imageUrl;
  final String? adminApproval;

  OrderEntity({
    required this.id,
    required this.clientId,
    required this.clientName,
    required this.designerId,
    required this.designerName,
    required this.designType,
    this.description,
    this.price,
    required this.status,
    required this.createAt,
    this.imageUrl,
    this.adminApproval,
  });
}
