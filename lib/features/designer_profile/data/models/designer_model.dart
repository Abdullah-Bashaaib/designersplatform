import 'package:designers_platform/features/auth/data/models/user_model.dart';

import '../../domain/entities/designer.dart';

class DesignerModel extends Designer {
  DesignerModel({
    required super.user,
    required super.reviewId,
    required super.bio,
    required super.numberBank,
    required super.nameBank,
    required super.specialization,
    required super.isAvailable,
    required super.totalOrders,
    required super.worksCount,
    super.averageRating,
    super.reviewsCount,
    super.workList,
  });

  factory DesignerModel.fromJson(Map<String, dynamic> json) {
    return DesignerModel(
        user: UserModel.fromJson(json['user']),
        reviewId: json['reviewId'],
        bio: json['bio'],
        numberBank: json['number_bank'],
        nameBank: json['name_bank'],
        specialization: json['specialization'],
        isAvailable: json['is_available'],
        totalOrders: json['total_orders'],
        worksCount: json['works_count'],
        averageRating: json['average_review'],
        reviewsCount: json['review_count']);
  }
  factory DesignerModel.fromEntity(Designer designer) {
    return DesignerModel(
      user: designer.user,
      reviewId: designer.reviewId,
      reviewsCount: designer.reviewsCount,
      bio: designer.bio,
      numberBank: designer.numberBank,
      nameBank: designer.nameBank,
      specialization: designer.specialization,
      isAvailable: designer.isAvailable,
      totalOrders: designer.totalOrders,
      worksCount: designer.worksCount,
      averageRating: designer.averageRating,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': (user as UserModel).toMap(),
      'reviewId': reviewId,
      'bio': bio,
      'number_bank': numberBank,
      'name_bank': nameBank,
      'specialization': specialization,
      'is_available': isAvailable,
      'total_orders': totalOrders,
      'works_count': worksCount,
      'average_review': averageRating,
      'review_count': reviewsCount
    };
  }
}
