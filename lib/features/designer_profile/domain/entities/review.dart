class Review {
  final String id;
  final String designerId;
  final String clientId;
  final String orderId;
  final String? feedback;
  final DateTime timeReview;
  final String nameClint;
  final double valueReview;

  Review({
    required this.id,
    required this.clientId,
    required this.designerId,
    required this.nameClint,
    required this.orderId,
    this.feedback,
    required this.timeReview,
    required this.valueReview,
  });
}
