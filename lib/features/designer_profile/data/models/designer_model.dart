import '../../domain/entities/designer.dart';

class DesignerModel extends Designer {
  DesignerModel({
    required super.id,
    required super.name,
    required super.email,
    required super.role,
    required super.avatarUrl,
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
        id: json['id'],
        name: json['name'],
        email: json['email'],
        role: json['role'],
        avatarUrl: json['avatarUrl'] ?? '',
        reviewId: json['review_id'] ?? '0',
        bio: json['bio'] ?? 'لا توجد بيانات',
        numberBank: json['number_bank'] ?? 0,
        nameBank: json['name_bank'] ?? 'لا توجد بيانات',
        specialization: json['specialization'] ?? 'لا توجد بيانات',
        isAvailable: json['is_available'] ?? 0,
        totalOrders: json['total_orders'] ?? 0,
        worksCount: json['works_count'] ?? 0,
        averageRating: json['average_review'] ?? 0,
        reviewsCount: json['review_count'] ?? 0);
  }
  factory DesignerModel.fromEntity(Designer designer) {
    return DesignerModel(
      id: designer.id,
      name: designer.name,
      email: designer.email,
      role: designer.role,
      avatarUrl: designer.avatarUrl,
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
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'avatarUrl': avatarUrl,
      'review_id': reviewId,
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
