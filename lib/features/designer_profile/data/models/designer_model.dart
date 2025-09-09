import 'package:designers_platform/features/auth/data/models/user_model.dart';

import '../../domain/entities/designer.dart';

class DesignerModel extends Designer {
  DesignerModel(
      {required super.user,
      required super.numberBank,
      required super.nameBank,
      required super.specialization,
      required super.isAvailable,
      required super.averageRating,
      required super.reviewsCount,
      required super.totalOrders,
      required super.worksCount,
      required super.workList});

  factory DesignerModel.fromJson(Map<String, dynamic> json) {
    UserModel userModel = UserModel.fromJson(json['user']);
    return DesignerModel(
        user: userModel,
        numberBank: json['numberBank'],
        nameBank: json['nameBank'],
        specialization: json['specialization'],
        isAvailable: json['isAvailable'],
        averageRating: json['averageRating'],
        reviewsCount: json['reviewsCount'],
        totalOrders: json['totalOrders'],
        worksCount: json['worksCount'],
        workList: json['workList']);
  }

  Map<String, dynamic> toJson() {
    return {
      'user': (user is UserModel)
          ? (user as UserModel).toMap()
          : UserModel.fromEntity(user).toMap(),
      'numberBank': numberBank,
      'nameBank': nameBank,
      'specialization': specialization,
      'isAvailable': isAvailable,
      'averageRating': averageRating,
      'reviewsCount': reviewsCount,
      'totalOrders': totalOrders,
      'worksCount': worksCount,
      'workList': workList,
    };
  }
}
