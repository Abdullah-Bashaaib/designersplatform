import 'package:designers_platform/features/designer_profile/domain/entities/work.dart';

import '../../../auth/domain/entities/user.dart';

class Designer {
  User user;
  int? numberBank;
  String? nameBank;
  String? specialization;
  bool? isAvailable;
  double? averageRating; // محسوب من reviews
  int? reviewsCount; // عدد التقييمات
  int? totalOrders; // عدد الطلبات
  int? worksCount; // عدد الأعمال
  List<Work>? workList;

  Designer(
      {required this.user,
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
