import 'package:designers_platform/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DesignStatus extends StatelessWidget {
  final String? status;
  const DesignStatus({super.key, this.status});

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
      child: status == 'مقبول'
          ? IconButton(onPressed: () {}, icon: Icon(Icons.chat))
          : Text(
              status!,
              style: TextStyle(
                color: _statusColor(status),
                fontWeight: FontWeight.w600,
                fontSize: 13.sp,
              ),
            ),
    );
  }
}
