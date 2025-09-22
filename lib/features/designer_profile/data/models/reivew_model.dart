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
      clientId: json['clientId'],
      designerId: json['designerId'],
      nameClint: json['nameClint'],
      orderId: json['orderId'],
      timeReview: json['timeReview'],
      valueReview: json['value_review'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'clientId': clientId,
      'designerId': designerId,
      'nameClint': nameClint,
      'orderId': orderId,
      'timeReview': timeReview,
      'value_review': valueReview,
    };
  }
}
