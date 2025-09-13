import '../../domain/entities/designer.dart';

class DesignerModel extends Designer {
  DesignerModel(
      {required super.id,
      required super.name,
      required super.email,
      required super.password,
      required super.role,
      required super.avatarUrl,
      required super.bio,
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
    return DesignerModel(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        password: json['password'],
        role: json['role'],
        avatarUrl: json['avatar_url'],
        bio: json['bio'],
        numberBank: json['number_bank'],
        nameBank: json['name_bank'],
        specialization: json['specialization'],
        isAvailable: json['is_available'],
        averageRating: json['average_rating'],
        reviewsCount: json['reviews_count'],
        totalOrders: json['total_orders'],
        worksCount: json['works_count'],
        workList: json['work_list']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'role': role,
      'avatar_url': avatarUrl,
      'bio': bio,
      'number_bank': numberBank,
      'name_bank': nameBank,
      'specialization': specialization,
      'is_available': isAvailable,
      'average_rating': averageRating,
      'reviews_count': reviewsCount,
      'total_orders': totalOrders,
      'works_count': worksCount,
      'work_list': workList,
    };
  }
}
