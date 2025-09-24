class OrderEntity {
  final String clientId;
  final String designerId;
  final String designerName;
  final String imageUrl;

  OrderEntity(
      {required this.clientId,
      required this.designerId,
      required this.designerName,
      required this.imageUrl});
}
