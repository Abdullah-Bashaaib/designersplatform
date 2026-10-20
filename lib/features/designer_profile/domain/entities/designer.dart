import 'package:designers_platform/features/designer_profile/domain/entities/work.dart';

class Designer {
  String id;
  String name;
  String email;
  String role;
  String? avatarUrl;
  String? bio;
  int? numberBank;
  String? nameBank;
  String? specialization;
  int? isAvailable;
  String reviewId;
  double? averageRating; // محسوب من reviews
  int? reviewsCount; // عدد التقييمات
  int? totalOrders; // عدد الطلبات
  int? worksCount; // عدد الأعمال
  List<Work>? workList;

  Designer({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.avatarUrl,
    required this.reviewId,
    required this.bio,
    this.reviewsCount,
    this.averageRating,
    required this.numberBank,
    required this.nameBank,
    required this.specialization,
    required this.isAvailable,
    required this.totalOrders,
    required this.worksCount,
    required this.workList,
  });
}
