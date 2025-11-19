import 'package:designers_platform/core/utils/app_styles.dart';
import 'package:designers_platform/features/order_management/domain/entity/orders.dart';
import 'package:designers_platform/features/order_management/presentation/pages/chat_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

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
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
      decoration: AppStyles.cardDecoration,
      child: order?.status == 'مقبول'
          ? IconButton(
              onPressed: () {
                Get.to(() => ChatOrder(
                      order: order!,
                    ));
              },
              icon: Icon(Icons.chat))
          : Text(
              order!.status,
              style: TextStyle(
                color: _statusColor(order?.status),
                fontWeight: FontWeight.w600,
                fontSize: 13.sp,
              ),
            ),
    );
  }
}
