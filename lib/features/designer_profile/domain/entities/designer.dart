import 'package:designers_platform/features/auth/domain/entities/user.dart';
import 'package:designers_platform/features/designer_profile/domain/entities/work.dart';

class Designer {
  User user;
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
    required this.user,
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
