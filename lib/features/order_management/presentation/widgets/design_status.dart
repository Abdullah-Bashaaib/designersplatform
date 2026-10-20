import 'package:designers_platform/features/order_management/domain/entity/orders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class DesignStatus extends StatelessWidget {
  final OrderEntity? order;
  const DesignStatus({super.key, this.order});

  Color _statusColor(String? status) {
    switch (status) {
      case "مكتمل":
        return Colors.green;
      case "قيد الانتظار":
        return Colors.amber;
      case "مرفوض":
        return Colors.redAccent;
      case "مقبول":
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    final status = order?.status;

    // if (status == 'مقبول') {
    //   return IconButton(
    //     onPressed: () {
    //       Get.to(() => ChatOrder(order: order!));
    //     },
    //     icon: const Icon(Icons.chat),
    //   );
    // }

    // if (status == 'مكتمل') {
    //   return IconButton(
    //     onPressed: () {
    //       Get.to(() => ViewCompletedOrder(imageUrl: order!.imageUrl));
    //     },
    //     icon: const Icon(Icons.visibility),
    //   );
    // }
    return Text(
      status ?? '',
      style: TextStyle(
        color: _statusColor(status),
        fontWeight: FontWeight.w600,
        fontSize: 13.sp,
      ),
    );
  }
}
