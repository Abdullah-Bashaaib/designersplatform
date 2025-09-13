import 'package:designers_platform/features/designer_profile/domain/entities/work.dart';

class Designer {
  final String? id;
  final String name;
  final String email;
  final String password;
  final String role;
  final String? avatarUrl;
  String? bio;
  int? numberBank;
  String? nameBank;
  String? specialization;
  int? isAvailable;
  double? averageRating; // محسوب من reviews
  int? reviewsCount; // عدد التقييمات
  int? totalOrders; // عدد الطلبات
  int? worksCount; // عدد الأعمال
  List<Work>? workList;

  Designer(
      {required this.id,
      required this.name,
      required this.email,
      required this.password,
      required this.role,
      required this.avatarUrl,
      required this.bio,
      required this.numberBank,
      required this.nameBank,
      required this.specialization,
      required this.isAvailable,
      required this.averageRating,
      required this.reviewsCount,
      required this.totalOrders,
      required this.worksCount,
      required this.workList});
}
