class OrderEntity {
  final String id;
  final String clientId;
  final String clientName;
  final String designerId;
  final String designerName;
  final String designName;
  final String designType;
  final String? description;
  final double? price;
  final String status;
  final DateTime createAt;
  final String? imageUrl;
  final int? rate;
  final String? feedback;

  OrderEntity({
    required this.id,
    required this.clientId,
    required this.clientName,
    required this.designerId,
    required this.designerName,
    required this.designName,
    required this.designType,
    this.description,
    this.price,
    required this.status,
    required this.createAt,
    this.imageUrl,
    this.rate,
    this.feedback,
  });
}
