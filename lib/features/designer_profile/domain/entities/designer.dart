import 'package:designers_platform/features/designer_profile/domain/entities/work.dart';

import '../../../auth/domain/entities/user.dart';

class Designer {
  late final User user;
  late final int numberBank;
  late final String nameBank;
  late final String specialization;
  late final bool isAvailable;
  late final double averageRating; // محسوب من reviews
  late final int reviewsCount; // عدد التقييمات
  late final int totalOrders; // عدد الطلبات
  late final int worksCount; // عدد الأعمال
  late final List<Work> workList;

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
