import '../../domain/entities/review.dart';

class ReviewModel extends Review {
  ReviewModel({
    required super.id,
    required super.clientId,
    required super.designerId,
    required super.nameClint,
    required super.orderId,
    required super.timeReview,
    required super.valueReview,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'],
      clientId: json['client_id'],
      designerId: json['designer_id'],
      nameClint: json['name_clint'],
      orderId: json['order_id'],
      timeReview: json['time_review'],
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
      'time_review': timeReview,
      'value_review': valueReview,
    };
  }
}
