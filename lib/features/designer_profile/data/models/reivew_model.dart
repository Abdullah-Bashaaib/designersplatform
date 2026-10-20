import '../../domain/entities/review.dart';

class ReviewModel extends Review {
  ReviewModel(
      {required super.id,
      required super.clientId,
      required super.designerId,
      required super.nameClint,
      required super.orderId,
      required super.timeReview,
      required super.valueReview,
      super.feedback});

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'],
      clientId: json['client_id'],
      designerId: json['designer_id'],
      nameClint: json['name_clint'],
      orderId: json['order_id'],
      feedback: json['feedback'],
      timeReview: DateTime.parse(json['time_review'] as String),
      valueReview: json['value_review'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'client_id': clientId,
      'designer_id': designerId,
      'name_clint': nameClint,
      'order_id': orderId,
      'feedback': feedback,
      'time_review': timeReview.toIso8601String(),
      'value_review': valueReview,
    };
  }
}
