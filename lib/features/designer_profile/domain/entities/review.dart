class Review {
  final String id;
  final String designerId;
  final String clientId;
  final String orderId;
  final String timeReview;
  final String nameClint;
  final int valueReview;

  Review({
    required this.id,
    required this.clientId,
    required this.designerId,
    required this.nameClint,
    required this.orderId,
    required this.timeReview,
    required this.valueReview,
  });
}
