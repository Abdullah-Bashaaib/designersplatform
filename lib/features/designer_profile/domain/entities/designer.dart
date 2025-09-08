import 'package:designers_platform/features/designer_profile/domain/entities/work.dart';
import '../../../auth/domain/entities/user.dart';

class Designer {
  final User user;
  final int numberBank;
  final String nameBank;
  final String specialization;
  final bool isAvailable;
  final double averageRating; // محسوب من reviews
  final int reviewsCount; // عدد التقييمات
  final int totalOrders; // عدد الطلبات
  final int worksCount; // عدد الأعمال
  final List<Work> workList;

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
